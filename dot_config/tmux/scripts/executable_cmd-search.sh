#!/bin/sh
# Fuzzy-find commands typed in any pane of the current session, then jump to
# that pane in copy mode with the command at the top of the screen.
# Usage: run from a tmux popup (display-popup doesn't expand #{formats}, so the
# session is looked up here instead of being passed in).
#
# Finding commands:
#   1. Prompt marks: shells that emit OSC 133 (fish 4, or any shell configured
#      for it) let tmux flag prompt lines; `capture-pane -F` exposes them
#      (tmux 3.7+). This doesn't depend on what the prompt looks like.
#   2. Fallback, for panes without marks (e.g. Kali's default zsh, older tmux):
#      lines matching a prompt regex.
# The regex is also used to strip the prompt off marked lines, so the list
# shows just the command. Override it (POSIX ERE, up to the end of the prompt)
# with: set -g @cmd-search-prompt '<regex>'
#   default matches:  user@host ~/dir (branch)> cmd   (fish)
#                     └─$ cmd                         (Kali zsh)
#                     $ cmd / # cmd                   (plain sh/bash)

session=$(tmux display-message -p '#{session_id}')
prompt=$(tmux show -gqv @cmd-search-prompt)
[ -n "$prompt" ] || prompt='^[^ ]+@[^ ]+ [^>]*> |└─[$#] |^[$#] '

# Print "<line> <flags> <text>" for every line of a pane, where <line> is
# negative in the history and 0.. on the visible screen (capture-pane -L).
capture() {
  tmux capture-pane -p -F -L -S - -t "$1" 2>/dev/null ||
    # tmux without -F/-L: number the lines ourselves, no flags
    tmux capture-pane -p -S - -t "$1" | awk -v hsize="$2" '{ print NR - 1 - hsize, "-", $0 }'
}

sel=$(
  tmux list-panes -s -t "$session" -F '#{pane_id} #{window_index}.#{pane_index} #{history_size} #{cursor_y}' |
    while read -r pane name hsize cursor; do
      capture "$pane" "$hsize" |
        awk -v pane="$pane" -v name="$name" -v cursor="$cursor" -v re="$prompt" '
          {
            n++
            line[n] = $1
            marked[n] = ($2 ~ /P/)
            text[n] = substr($0, length($1) + length($2) + 3)
            if (marked[n]) has_marks = 1
          }
          END {
            for (i = 1; i <= n; i++) {
              if (line[i] == cursor) continue  # the prompt currently waiting for input
              # capture-pane trims trailing spaces, so an empty prompt ends in
              # ">" not "> "; add one back so the prompt regex still matches it
              t = text[i] " "
              if (has_marks) {
                if (!marked[i]) continue
                if (match(t, re)) t = substr(t, RSTART + RLENGTH)
              } else {
                if (!match(t, re)) continue
                t = substr(t, RSTART + RLENGTH)
              }
              sub(/ +$/, "", t)
              if (t == "") continue  # bare prompt, no command
              # copy-mode goto-line takes lines scrolled up from the bottom
              offset = line[i] < 0 ? -line[i] : 0
              printf "%s\t%d\t%s\t%s\n", pane, offset, name, t
            }
          }'
    done |
    fzf --delimiter='\t' --with-nth=3.. --tac --no-sort --prompt='command> '
) || exit 0

pane=$(printf '%s\n' "$sel" | cut -f1)
offset=$(printf '%s\n' "$sel" | cut -f2)

tmux select-window -t "$pane" \; select-pane -t "$pane" \; \
  copy-mode -t "$pane" \; send-keys -t "$pane" -X goto-line "$offset" \; \
  send-keys -t "$pane" -X top-line

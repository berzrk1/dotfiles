#!/bin/sh
# Fuzzy-find commands typed in any pane of the current session, then jump to
# that pane in copy mode with the command at the top of the screen.
# Usage: run from a tmux popup (display-popup doesn't expand #{formats}, so the
# session is looked up here instead of being passed in).
#
# Commands are found by the starship prompt (same on every machine):
#   ╰─ cmd                 normal prompt, with its clock on the line above
#   user@host:~/dir$ cmd   report prompt (Alt+O)

session=$(tmux display-message -p '#{session_id}')
prompt='^╰─ |^[^ ]+@[^ :]+:[^ ]*[$#] '

sel=$(
  tmux list-panes -s -t "$session" -F '#{pane_id} #{window_index}.#{pane_index} #{history_size} #{cursor_y}' |
    while read -r pane name hsize cursor; do
      tmux capture-pane -p -S - -t "$pane" |
        awk -v pane="$pane" -v name="$name" -v hsize="$hsize" -v cursor="$cursor" -v re="$prompt" '
          # One pass, keeping only what the next prompt needs. Each prompt
          # line ends the previous command; its output runs up to the last
          # line that is not blank and not the first line of a starship prompt.
          function flush() {
            if (!p || pl == cursor || pc == "") return  # none yet / waiting for input / bare prompt
            if (pt != "") key = pt  # sort key: commands without a clock keep the time of the one before
            offset = pl < 0 ? -pl : 0  # copy-mode goto-line takes lines scrolled up from the bottom
            printf "%s\t%s\t%d\t%d\t%d\t%s\t%s\t%s\n", key, pane, offset, pl, last, name, pt, pc
          }
          {
            ln = NR - 1 - hsize  # negative in the history, 0.. on the visible screen
            h = index($0, "╭─")
            # capture-pane trims trailing spaces, so a bare prompt ends in "╰─"
            # not "╰─ "; add one back so the prompt regex still matches it
            if ((index($0, "╰─") == 1 || index($0, "@")) && match($0 " ", re)) {  # cheap filter first
              flush()
              t = substr($0 " ", RSTART + RLENGTH)
              sub(/ +$/, "", t)
              p = 1; pl = ln; pc = t; last = ln
              # time = clock at the end of the starship line above the command
              pt = ""
              if (top != "" && match(top, /[0-9][0-9]:[0-9][0-9]:[0-9][0-9] *$/))
                pt = substr(top, RSTART, 8)
            } else if (NF && h != 1) last = ln
            top = h == 1 ? $0 : ""
          }
          END { flush() }'
    done |
    sort -s -t "$(printf '\t')" -k1,1 | cut -f2- |  # all panes, oldest first
    fzf --delimiter='\t' --with-nth=5.. --tac --no-sort --prompt='command> ' \
      --preview='tmux capture-pane -p -e -t {1} -S {3} -E {4}' --preview-window=down,60%
) || exit 0

pane=$(printf '%s\n' "$sel" | cut -f1)
offset=$(printf '%s\n' "$sel" | cut -f2)

tmux select-window -t "$pane" \; select-pane -t "$pane" \; \
  copy-mode -t "$pane" \; send-keys -t "$pane" -X goto-line "$offset" \; \
  send-keys -t "$pane" -X top-line

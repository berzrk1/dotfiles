if status is-interactive; and command -q fzf
    # ━━━━━━━━━ fzf.fish ━━━━━━━━━
    if functions -q fzf_configure_bindings
        set -g fzf_fd_opts --hidden --exclude=.git
        set -gx fzf_preview_dir_cmd eza --long --header --icons=always --all --color=always --group-directories-first --no-user
        fzf_configure_bindings --directory=\cf # Ctrl+F files

        function _fzf_search_directories -d 'fzf.fish directory search, directories only'
            set -l opts $fzf_fd_opts
            set -g fzf_fd_opts $opts --type=directory
            _fzf_search_directory
            set -g fzf_fd_opts $opts
        end
        bind -M default \ct _fzf_search_directories
        bind -M insert \ct _fzf_search_directories
    end

    # ━━━━━━━━━ Tab completion ━━━━━━━━━
    fzf --fish | sed -n '/^### completion.fish ###/,/^### end: completion.fish ###/p' | source
    bind -M default \t fzf_complete
    bind -M insert \t fzf_complete
    set -g FZF_COMPLETION_OPTS --select-1 --exit-0 # one match: insert it without opening fzf
end

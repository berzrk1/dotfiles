if status is-interactive
    # after conf.d, so macOS has Homebrew on PATH
    if command -q starship
        starship init fish | source
        # on Enter, redraw the prompt so its clock shows when the command ran
        function starship_transient_prompt_func
            # drop the leading clear-screen code: on this redraw it erases the typed command
            starship prompt $argv | string collect -N | string replace -r '^\e\[J' '' | string collect
        end
        enable_transience
        bind -M default \eo report_prompt # Alt+O
        bind -M insert \eo report_prompt
    end
end

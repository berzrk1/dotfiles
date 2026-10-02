function report_prompt --description 'Toggle a plain prompt for report screenshots'
    set -l main ~/.config/starship/starship.toml
    set -l report ~/.config/starship/report.toml
    if test "$STARSHIP_CONFIG" = "$report"
        set -gx STARSHIP_CONFIG $main
    else
        set -gx STARSHIP_CONFIG $report
    end
    commandline -f repaint
end

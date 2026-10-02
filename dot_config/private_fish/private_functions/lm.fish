function lm --wraps eza --description 'List all files, newest last'
    if not command -q eza
        missing_package eza
        return
    end
    eza --long --header -a --icons --git --hyperlink=auto -s modified $argv
end

function la --wraps eza --description 'List all files, including hidden'
    if not command -q eza
        missing_package eza
        return
    end
    eza --long --header -a --icons --git --group-directories-first --hyperlink=auto $argv
end

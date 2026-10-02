function lta --wraps eza --description 'List all files as a tree, including hidden'
    if not command -q eza
        missing_package eza
        return
    end
    eza --long --header -a --icons --tree --git --group-directories-first --hyperlink=auto $argv
end

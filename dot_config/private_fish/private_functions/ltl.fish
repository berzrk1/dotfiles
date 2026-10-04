function ltl --wraps eza --description 'List files as a tree with long format'
    if not command -q eza
        missing_package eza
        return
    end
    eza --long --header --icons --tree --git --group-directories-first --hyperlink=auto $argv
end

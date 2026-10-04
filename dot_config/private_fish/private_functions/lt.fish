function lt --wraps eza --description 'List files as a tree'
    if not command -q eza
        missing_package eza
        return
    end
    eza --header --icons --tree --git --group-directories-first --hyperlink=auto $argv
end

function l --wraps eza --description 'List files (long, icons, git status)'
    if not command -q eza
        missing_package eza
        return
    end
    eza --long --header --icons --git --group-directories-first --hyperlink=auto $argv
end

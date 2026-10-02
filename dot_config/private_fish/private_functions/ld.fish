function ld --wraps eza --description 'List directories only'
    if not command -q eza
        missing_package eza
        return
    end
    eza --long --header --icons -D --git --hyperlink=auto $argv
end

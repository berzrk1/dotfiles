function lt --wraps='eza --long --header --icons --tree --git --group-directories-first' --description 'alias lt=eza --long --header --icons --tree --git --group-directories-first'
    if type -f eza &>/dev/null
        eza --long --header --icons --tree --git --group-directories-first --hyperlink=auto $argv
    else
        missing_package eza
    end
end

function ls --wraps='eza --icons --git --group-directories-first' --description 'List through eza'
    if type -f eza &>/dev/null
        eza --icons --git --group-directories-first --hyperlink=auto $argv
    else
        missing_package eza
    end
end

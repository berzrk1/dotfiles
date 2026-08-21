function ls --wraps='eza --icons --git --group-directories-first' --description 'alias ls=eza --icons --git --group-directories-first'
    if type -f eza &>/dev/null
        eza --icons --git --group-directories-first --hyperlink=auto $argv
    else
        missing_package eza
    end
end

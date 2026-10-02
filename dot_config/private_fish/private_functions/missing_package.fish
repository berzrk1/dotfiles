function missing_package --description 'Print an error for a program that is not installed'
    echo (set_color red)"$argv[1] is not installed"(set_color normal) >&2
    return 127 # "command not found"
end

function pbpaste --description 'Cross-platform clipboard paste'
    if test (uname) = Darwin
        command pbpaste $argv
    else
        xclip -selection clipboard -o $argv
    end
end

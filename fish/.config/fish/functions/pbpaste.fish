function pbpaste --description 'Cross-platform clipboard paste'
    if test (uname) = Darwin
        command pbpaste $argv
    else if test "$XDG_SESSION_TYPE" = wayland
        wl-paste --no-newline $argv
    else
        xclip -selection clipboard -o $argv
    end
end

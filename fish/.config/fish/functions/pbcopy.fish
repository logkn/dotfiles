function pbcopy --description 'Cross-platform clipboard copy'
    if test (uname) = Darwin
        command pbcopy $argv
    else if test "$XDG_SESSION_TYPE" = wayland
        wl-copy $argv
    else
        xclip -selection clipboard -i $argv
    end
end

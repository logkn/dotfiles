function pbcopy --description 'Cross-platform clipboard copy'
    if test (uname) = Darwin
        command pbcopy $argv
    else
        xclip -selection clipboard $argv
    end
end

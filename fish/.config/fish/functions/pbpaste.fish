function pbpaste --wraps='xclip -selection clipboard -o' --description 'alias pbpaste=xclip -selection clipboard -o'
  xclip -selection clipboard -o $argv
        
end

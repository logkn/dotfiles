function pull --wraps='git pull $(git remote) $(git branch --show-current)' --description 'alias pull=git pull $(git remote) $(git branch --show-current)'
  git pull $(git remote) $(git branch --show-current) $argv
        
end

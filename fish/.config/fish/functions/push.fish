function push --wraps='git push origin $(git branch --show-current)' --description 'alias push=git push origin $(git branch --show-current)'
  git push origin $(git branch --show-current) $argv
        
end

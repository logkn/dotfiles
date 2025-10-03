function update-npm --wraps='npm update -g' --description 'alias update-npm=npm update -g'
  npm update -g $argv
        
end

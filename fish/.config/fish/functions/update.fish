function update --wraps='yay -Syu --batchinstall --devel --timeupdate --combinedupgrade' --description 'alias update=yay -Syu --batchinstall --devel --timeupdate --combinedupgrade'
  yay -Syu --batchinstall --devel --timeupdate --combinedupgrade $argv
        
end

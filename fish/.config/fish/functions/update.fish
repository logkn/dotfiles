function update --description 'Update system packages based on OS'
    switch (uname)
        case Linux
            yay -Syu --batchinstall --devel --timeupdate --combinedupgrade $argv
            npm install -g @openai/codex
        case Darwin
            brew upgrade $argv
            npm install -g @openai/codex
        case '*'
            echo "Unsupported OS: "(uname)
            return 1
    end
end

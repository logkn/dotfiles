function update --description 'Update system packages based on OS'
    switch (uname)
        case Linux
            yay -Syu --batchinstall --devel --combinedupgrade $argv
        case Darwin
            brew upgrade $argv
        case '*'
            echo "Unsupported OS: "(uname)
            return 1
    end
end

function os-icon
    switch (uname)
        case Darwin
            echo "󰀵" # Apple icon
        case Linux
            if test -f /etc/garuda-settings
                echo "󰣨" # Garuda icon
            else if test -f /etc/arch-release
                echo "󰣇" # Arch icon
            else
                echo "󰌽" # Generic Linux icon
            end
        case '*'
            echo "󰀶" # Generic OS icon
    end
end


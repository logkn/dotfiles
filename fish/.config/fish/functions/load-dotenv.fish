function load-dotenv
    set -f envfile "$argv"
    if not test -f "$envfile"
        echo "Unable to load $envfile"
        return 1
    end

    while read line
        if not string match -qr '^#|^$' "$line" # Skip comments and empty lines
            set item (string split -m 1 '=' $line)
            set -gx $item[1] $item[2] # Set global environment variable
            echo "Exported key $item[1]"
        end
    end <"$envfile"
end

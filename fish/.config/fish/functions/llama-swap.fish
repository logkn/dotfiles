function llama-swap --wraps=./run/media/logan/storage/Development/OpenSource/llama-swap/build/llama-swap-linux-amd64 --wraps=/run/media/logan/storage/Development/OpenSource/llama-swap/build/llama-swap-linux-amd64 --description 'alias llama-swap=/run/media/logan/storage/Development/OpenSource/llama-swap/build/llama-swap-linux-amd64'
    set -l config_flag --config
    set -l config_path "$HOME/.config/llama-swap/config.yaml"
    set -l has_config_flag false
    set -l args

    for arg in $argv
        if test "$has_config_flag" = true
            set config_path $arg
            set has_config_flag false
        else if test "$arg" = "$config_flag"
            set has_config_flag true
        else
            set -a args $arg
        end
    end

    if test "$has_config_flag" = true
        set -a args "$config_flag" "$config_path"
    end

    /run/media/logan/storage/Development/OpenSource/llama-swap/build/llama-swap-linux-amd64 $args $config_flag $config_path

end

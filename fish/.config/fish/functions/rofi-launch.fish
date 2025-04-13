function rofi-launch
    set -l type $argv[1]
    set -l rofi_cmd "sh ~/.config/rofi/launchers/type-$type/launcher.sh"
    eval $rofi_cmd
end

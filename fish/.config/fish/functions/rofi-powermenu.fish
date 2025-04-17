function rofi-powermenu
    set -l type $argv[1]
    set -l rofi_cmd "sh ~/.config/rofi/powermenu/type-$type/powermenu.sh"
    eval $rofi_cmd
end

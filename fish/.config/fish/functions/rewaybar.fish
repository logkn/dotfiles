function rewaybar --wraps='pkill waybar && waybar &' --wraps='pkill waybar; hyprctl dispatch exec waybar' --description 'alias rewaybar=pkill waybar; hyprctl dispatch exec waybar'
  pkill waybar; hyprctl dispatch exec waybar $argv
        
end

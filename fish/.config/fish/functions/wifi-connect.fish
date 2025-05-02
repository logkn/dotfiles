function wifi-connect --wraps='nmcli device wifi connect ' --wraps='nmcli device wifi connect Bill Wi the Science Fi' --wraps='nmcli device wifi connect "Bill Wi the Science Fi"' --description 'alias wifi-connect=nmcli device wifi connect "Bill Wi the Science Fi"'
  nmcli device wifi connect "Bill Wi the Science Fi" $argv
        
end

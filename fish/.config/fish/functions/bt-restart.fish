function bt-restart --description "Restart bluetooth daemon by killing root bluetoothd process"
    set -l pid (ps xau | grep bluetoothd | grep "^root" | awk '{print $2}')

    if test -z "$pid"
        echo "No root bluetoothd process found"
        return 1
    end

    echo "Killing bluetoothd process (PID: $pid)"
    sudo kill -9 $pid

    if test $status -eq 0
        echo "Bluetooth daemon killed successfully. It should restart automatically."
    else
        echo "Failed to kill bluetooth daemon"
        return 1
    end
end


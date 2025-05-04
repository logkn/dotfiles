function killport
    if test (count $argv) -ne 1
        echo "Usage: killport <port>"
        return 1
    end

    set port $argv[1]
    set pids (lsof -ti :$port)

    if test -z "$pids"
        echo "No processes found using port $port"
        return 0
    end

    echo "Killing processes using port $port: $pids"
    for pid in $pids
        kill -9 $pid
    end
end

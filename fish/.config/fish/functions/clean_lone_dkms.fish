function clean_lone_dkms
    for i in /var/lib/dkms/*/*/source
        if not test -e "$i"
            echo Removing (dirname "$i")
            sudo rm -rf (dirname "$i")
        end
    end
end

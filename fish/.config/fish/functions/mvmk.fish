function mvmk --description Move\ files\ and\ create\ target\ directories\ if\ they\ don\'t\ exist
    if test (count $argv) -lt 2
        echo "Usage: mvmk SOURCE... DESTINATION" >&2
        return 1
    end

    # Get all arguments except the last one (these are the sources)
    set -l sources $argv[1..-2]
    # Get the last argument (this is the destination)
    set -l dest $argv[-1]

    # If moving multiple files, destination must be a directory
    if test (count $sources) -gt 1
        if test -e $dest; and not test -d $dest
            echo "mvmk: target '$dest' is not a directory" >&2
            return 1
        end
    end

    # Get the target directory path
    set -l target_dir
    if test -d $dest
        set target_dir $dest
    else
        set target_dir (dirname $dest)
    end

    # Create the target directory if it doesn't exist
    if not test -e $target_dir
        mkdir -p $target_dir
        or begin
            echo "mvmk: failed to create directory '$target_dir'" >&2
            return 1
        end
    end

    # Perform the move operation with all original arguments
    command mv $argv
    or begin
        echo "mvmk: mv operation failed" >&2
        return 1
    end
end

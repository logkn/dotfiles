function uv-init --wraps='uv python pin 3.13 && uv init && rm main.py' --description 'alias uv-init=uv python pin 3.13 && uv init && rm main.py'
    set -l pyver 3.13
    argparse -n uv-init 'v/version=' -- $argv
    or return
    if set -q _flag_version
        set pyver $_flag_version
    end
    uv python pin $pyver && uv init $argv && rm main.py && mkdir src && touch src/__init__.py && mkdir tests && touch tests/__init__.py
end

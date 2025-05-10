function uv-init --wraps='uv pin python 3.12 && uv init && rm hello.py' --wraps='uv python pin 3.12 && uv init && rm hello.py' --description 'alias uv-init=uv python pin 3.12 && uv init && rm hello.py'
    uv python pin 3.12 && uv init && rm main.py $argv && mkdir src && touch src/__init__.py && mkdir tests && touch tests/__init__.py
end

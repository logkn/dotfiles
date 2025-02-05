function uv-init --wraps='uv pin python 3.12 && uv init && rm hello.py' --wraps='uv python pin 3.12 && uv init && rm hello.py' --description 'alias uv-init=uv python pin 3.12 && uv init && rm hello.py'
  uv python pin 3.12 && uv init && rm hello.py $argv
        
end

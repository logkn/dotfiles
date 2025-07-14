function gp-project-start --description "Start up a G-P project."
    source .venv/bin/activate.fish && export PYTHONPATH=. && configure_ca
    if test -f uv.lock
        uv sync $argv
    else
        poetry sync $argv
    end
end

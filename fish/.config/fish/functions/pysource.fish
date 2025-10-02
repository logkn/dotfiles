function pysource --wraps='source .venv/bin/activate.fish && export PYTHONPATH=.' --description 'alias pysource=source .venv/bin/activate.fish && export PYTHONPATH=.'
    source .venv/bin/activate.fish && set -x PYTHONPATH . $argv

end

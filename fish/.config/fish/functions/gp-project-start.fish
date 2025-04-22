# function configure_ca --wraps='sh scripts/configure_ca_local.sh --profile lknapp || sh scripts/configure_ca.sh --profile lknapp' --description 'alias configure_ca=sh scripts/configure_ca_local.sh --profile lknapp || sh scripts/configure_ca.sh --profile lknapp'
#   sh scripts/configure_ca_local.sh --profile lknapp || sh scripts/configure_ca.sh --profile lknapp $argv
#
# end

function gp-project-start --wraps='source .venv/bin/activate.fish && export PYTHONPATH=. && configure_ca && poetry sync' --description "Start up a G-P project."
    source .venv/bin/activate.fish && export PYTHONPATH=. && configure_ca && poetry sync $argv
end

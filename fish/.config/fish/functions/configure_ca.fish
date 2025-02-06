function configure_ca --wraps='sh scripts/configure_ca_local.sh --profile lknapp || sh scripts/configure_ca.sh --profile lknapp' --description 'alias configure_ca=sh scripts/configure_ca_local.sh --profile lknapp || sh scripts/configure_ca.sh --profile lknapp'
  sh scripts/configure_ca_local.sh --profile lknapp || sh scripts/configure_ca.sh --profile lknapp $argv
        
end

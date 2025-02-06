function aws-ca-init --wraps='aws sso login --profile lknapp && configure_ca' --description 'alias aws-ca-init=aws sso login --profile lknapp && configure_ca'
  aws sso login --profile lknapp && configure_ca $argv
        
end

function aws_setup
    aws codeartifact login --tool npm --domain gp-prod --domain-owner 237156726900 --repository ai-engineering
    set -gx ARTIFACT_AUTH_TOKEN (aws codeartifact get-authorization-token                     --domain gp-prod                     --domain-owner 237156726900                     --query authorizationToken --output text) $argv

end

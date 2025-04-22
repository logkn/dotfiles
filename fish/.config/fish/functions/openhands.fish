function openhands
    docker run -it --rm --pull=always \
        -e SANDBOX_RUNTIME_CONTAINER_IMAGE=docker.all-hands.dev/all-hands-ai/runtime:0.30-nikolaik \
        -e LOG_ALL_EVENTS=true \
        -e LLM_OLLAMA_BASE_URL="http://host.docker.internal:11434" \
        -v /var/run/docker.sock:/var/run/docker.sock \
        -v ~/.openhands-state:/.openhands-state \
        -p 3000:3000 \
        --add-host host.docker.internal:host-gateway \
        --name openhands-app \
        docker.all-hands.dev/all-hands-ai/openhands:0.30
end

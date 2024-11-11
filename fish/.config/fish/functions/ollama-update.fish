function ollama-update
    ollama list | tail -n +2 | string split ' ' -f1 | while read -l model        
        ollama pull $model    
    end
end

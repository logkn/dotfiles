function llama-serve --wraps='llama-server --models-preset ~/.config/llamacpp/models.ini' --description 'alias llama-serve=llama-server --models-preset ~/.config/llamacpp/models.ini'
    llama-server --models-preset ~/.config/llamacpp/models.ini $argv
end

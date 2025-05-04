function openwebui --wraps='DATA_DIR=~/.open-webui uvx --python 3.11 open-webui@latest serve' --description 'alias openwebui=DATA_DIR=~/.open-webui uvx --python 3.11 open-webui@latest serve'
  DATA_DIR=~/.open-webui uvx --python 3.11 open-webui@latest serve $argv
        
end

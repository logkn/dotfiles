function gs --wraps='gh auth switch && gh auth setup-git' --description 'alias gs=gh auth switch && gh auth setup-git'
  gh auth switch && gh auth setup-git $argv
        
end

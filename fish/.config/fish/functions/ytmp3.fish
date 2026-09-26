function ytmp3 --description 'Download YouTube audio as MP3 to ~/Downloads'
    command yt-dlp --extract-audio --audio-format mp3 --audio-quality 0 --paths "$HOME/Downloads" $argv
end

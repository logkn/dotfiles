function settings --wraps='QT_QPA_PLATFORM=xcb systemsettings' --description 'alias settings=QT_QPA_PLATFORM=xcb systemsettings'
  QT_QPA_PLATFORM=xcb systemsettings $argv
        
end

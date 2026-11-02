# A new compositor session can inherit Niri's old socket from the user manager.
# Clear it before vendor plugins (notably done.fish) detect the compositor.
if test -n "$UMBRIEL_SOCKET"
    set -e NIRI_SOCKET
end

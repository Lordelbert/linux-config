#!/bin/sh
export MPD_PORT=6601
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export QT_QPA_PLATFORMTHEME=qt5ct
fcitx
[[ -f ~/.Xmodmap ]] && xmodmap ~/.Xmodmap
xrdb -load "$HOME/.Xresources"
export XDG_CONFIG_HOME=/home/maxime/.config
#xrandr --output HDMI1 --left-of eDP1 --auto
exec i3

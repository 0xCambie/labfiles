#!/bin/sh

# nvidia-settings --asign CurrentMetaMode='DPY-1: nvidia-autoselect 0+0 {ForceCompositionPipeline=on}, DPy-2: nvidia-autoselect +1600+0 {ForceCompositionPipeline=on}'
# gwe --hide-window &
# /usr/bin/pipewire &
# /usr/bin/pipewire-pulse &

feh --bg-fill /home/frawd/Wallpapers/wallpaper.jpeg &
picom --config /home/frawd/.config/picom/picom.conf &
sxhkd &
dwmblocks &
setxkbmap es &
wmname LG3D &

exec dwm 

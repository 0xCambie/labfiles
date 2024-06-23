#!/bin/sh

# nvidia-settings --asign CurrentMetaMode='DPY-1: nvidia-autoselect 0+0 {ForceCompositionPipeline=on}, DPY-2: nvidia-autoselect +1600+0 {ForceCompositionPipeline=on}'
# gwe --hide-window &
# /usr/bin/pipewire &
# /usr/bin/pipewire-pulse &
feh --bg-fill /home/$USER/Wallpapers/wallpaper.jpeg &
picom --config /home/$USER/.config/picom/picom.conf &
sxhkd &
dwmblocks &
setxkbmap es &
wmname LG3D &

exec dwm 

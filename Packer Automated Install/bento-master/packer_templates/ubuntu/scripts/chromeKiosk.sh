#!bin/bash
Xaxis=$(xrandr --current | grep '*' | uniq | awk '{print $1}' | cut -d 'x' -f1)
Yaxis=$(xrandr --current | grep '*' | uniq | awk '{print $1}' | cut -d 'x' -f2)
chromium --kiosk --start-maximized --window-size=$Xaxis,$Yaxis --window-position=0,0

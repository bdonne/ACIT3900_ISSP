#!/bin/bash -eux
Xaxis=$(xrandr --current | grep '*' | uniq | awk '{print $1}' | cut -d 'x' -f1)
Yaxis=$(xrandr --current | grep '*' | uniq | awk '{print $1}' | cut -d 'x' -f2)
su vagrant
firefox http://learn.bcit.ca --kiosk --start-maximized --window-size=9000,9000 --window-position=0,0

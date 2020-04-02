#!/bin/bash -eux
# Config current Ubuntu into a Kiosk System
# Author: Jun.C

# download all necessary files from git
sudo wget https://github.com/bdonne/ACIT3900_ISSP/blob/master/Kiosk_conf_2/custom.conf
sudo wget https://github.com/bdonne/ACIT3900_ISSP/blob/master/Kiosk_conf_2/firefoxKiosk.sh
sudo wget https://github.com/bdonne/ACIT3900_ISSP/blob/master/Kiosk_conf_2/firefoxKiosk.sh.desktop
sudo wget https://github.com/bdonne/ACIT3900_ISSP/blob/master/Kiosk_conf_2/vagrant

# Auto Login
sudo echo "Setting up auto login ..."
sudo chown root:root ./custom.conf
sudo cp ./custom.conf /etc/gdm3/

# Setup xsession for kiosk system under vagrant a/c
sudo echo "Setting up xsession ..."
sudo chown root:root ./firefoxKiosk.sh
sudo chmod 766 ./firefoxKiosk.sh
sudo cp ./firefoxKiosk.sh /usr/share/xsessions/
sudo chown root:root ./firefoxKiosk.sh.desktop
sudo cp ./firefoxKiosk.sh.desktop /usr/share/xsessions/
sudo chown root:root ./vagrant
sudo chmod 600 ./vagrant
sudo cp ./vagrant  /var/lib/AccountsService/users/

# Disable all shortcuts
#sudo echo "Disable all keyboard short-cuts..."

#sudo -Hu vagrant dbus-launch gsettings list-keys org.gnome.settings-daemon.plugins.media-keys | xargs -I@ sudo -Hu vagrant dbus-launch gsettings set org.gnome.settings-daemon.plugins.media-keys @ ['']

#sudo -Hu vagrant dbus-launch gsettings list-keys org.gnome.desktop.wm.keybindings | xargs -I@ sudo -Hu vagrant dbus-launch gsettings set org.gnome.desktop.wm.keybindings @ ['']

#sudo -Hu vagrant dbus-launch gsettings list-keys org.gnome.shell.keybindings | xargs -I@ sudo -Hu vagrant dbus-launch gsettings set org.gnome.shell.keybindings @ ['']

#sudo -Hu vagrant dbus-launch gsettings set org.gnome.desktop.wm.keybindings close "['<Alt>F4']"

# Add a new user 'Admin'
sudo echo "Added 'Admin' and added it into sudo group"
sudo groupadd Admin
sudo useradd Admin -s /bin/bash -m -g Admin -G sudo
sudo usermod --password $(openssl passwd -1 Password) Admin

# Rename vagrant to student
sudo echo "rename vagrant to student"
sudo usermod -c 'student' vagrant

# Remove current vagrant a/c from sudo and admin group

sudo echo "removed vagrant from adm group."
sudo deluser vagrant adm

sudo echo "removed vagrant from sudo group."
sudo deluser vagrant sudo

# reboot
echo "reboot..."
#sleep 5s
reboot
#!/bin/bash
# Config current Ubuntu into a Kiosk System
# Author: Jun.C

# Auto Login
echo "Setting up auto login ..."
chown root:root ./custom.conf
cp ./custom.conf /etc/gdm3/

# Setup xsession for kiosk system under student a/c
echo "Setting up xsession ..."
chown root:root ./firefoxKiosk.sh
chmod 766 ./firefoxKiosk.sh
cp ./firefoxKiosk.sh /usr/share/xsessions/
chown root:root ./firefoxKiosk.sh.desktop
cp ./firefoxKiosk.sh.desktop /usr/share/xsessions/
chown root:root ./student
chmod 600 ./student
cat ./student > /var/lib/AccountsService/users/student

# Resolve apparmor issue
#systemctl stop apparmor.service
#if [ ! -d "$apparmor_dir" ]; then
#   mkdir -p "$apparmor_dir"
#   touch "$apparmor_file"
#fi
#cat 30_live_mode.conf > "$apparmor_file"
#systemctl start apparmor.service
#systemctl enable apparmor.service

# Resolve can't locate package issue
#add-apt-repository main
#add-apt-repository universe
#add-apt-repository restricted
#add-apt-repository multiverse
#apt-get update

# Change current user name to 'Admin'
#usermod -c 'Admin' "$cur_user"

# Install Chromium browser
#apt-get install chromium-browser
#update-alternatives --install /usr/bin/x-www-browser x-www-browser /usr/bin/chromium-browser 200

# Set Chromium as default brower for student A/C
#bash -c 'xdg-settings set default-web-browser chromium_chromium.desktop'

# Disable all shortcuts
echo "Disable all keyboard short-cuts..."

sudo -Hu student dbus-launch gsettings list-keys org.gnome.settings-daemon.plugins.media-keys | xargs -I@ sudo -Hu student dbus-launch gsettings set org.gnome.settings-daemon.plugins.media-keys @ ['']

sudo -Hu student dbus-launch gsettings list-keys org.gnome.desktop.wm.keybindings | xargs -I@ sudo -Hu student dbus-launch gsettings set org.gnome.desktop.wm.keybindings @ ['']

sudo -Hu student dbus-launch gsettings list-keys org.gnome.shell.keybindings | xargs -I@ sudo -Hu student dbus-launch gsettings set org.gnome.shell.keybindings @ ['']

sudo -Hu student dbus-launch gsettings set org.gnome.desktop.wm.keybindings close "['<Alt>F4']"

# Add a new user 'Admin'
echo "Added 'Admin' and added it into sudo group"
groupadd Admin
useradd Admin -s /bin/bash -m -g Admin -G sudo
usermod --password $(openssl passwd -1 Password) Admin

# Remove current student a/c from sudo and admin group
echo "removed student from sudo group."
deluser student sudo

echo "removed student from adm group."
deluser student adm

# reboot
echo "reboot in 5 seconds ..."
sleep 5s
reboot

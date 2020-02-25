#!/bin/bash
# Config current Ubuntu into a Kiosk System, Jun

apparmor_dir="/lib/systemd/system/apparmor.service.d/"
apparmor_file="/lib/systemd/system/apparmor.service.d/30_live_mode.conf"

cd ~/Kiosk_Config/
# Resolve apparmor issue
systemctl stop apparmor.service
if [ ! -d "$apparmor_dir"]; then
   mkdir -p "$apparmor_dir"
   touch "$apparmor_file"
fi
cat 30_live_mode.conf > "$apparmor_file"
systemctl start apparmor.service
systemctl enable apparmor.service

# Resolve can't locate package issue
add-apt-repository main
add-apt-repository universe
add-apt-repository restricted
add-apt-repository multiverse
apt-get update

# Change current user name to 'Admin'
usermod -c 'Admin' "$USER"

# Add a new user 'Student'
stu_ac_exists=grep -c 'Student:' /etc/passwd
if ["$stu_ac_exists" -ne 1]; then 
   useradd -s /bin/bash -d /home/Student/ -m Student
   usermod --password $(openssl passwd -1 Password) Student
fi

# Install Chromium browser
apt-get install chromium-browser
update-alternatives --install /usr/bin/x-www-browser x-www-browser /usr/bin/chromium-browser 200


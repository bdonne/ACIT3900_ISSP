#!/bin/bash

# script made from guide: https://www.raspberrypi.org/documentation/configuration/wireless/access-point.md

##############
# parameters #
##############

# NOT IMPLIMENTED
eth_if_name="eth0"
wlan_if_name="wlan0"
wap_ssid="ExamNet"
wap_pass="supersecretpassword" # must be 8+ characters long
wap_host_ip="192.168.4.1"
wap_host_cidr="24"
dhcp_range_min="192.168.4.2"
dhcp_range_max="192.168.4.20"
dhcp_range_mask="255.255.255.0"


#############
# functions #
#############

border="################"

# wraps input text with a border for better visibility
function label_title {
  echo $border
  echo "$1"
  echo $border
}

# exits and reports "failure" if previous command exits with code 1
function quiet_check_exit {
  if [ $? -ne 0 ]
  then
    echo "failure"
    exit 1
  fi
}

# presents input followed by "success" or "failure" if depending on exit code
function check_exit {
  if [ $? == 0 ]
  then
    echo $border
    echo "$1 success"
    echo $border
  else
    echo $border
    echo "$1 failure"
    echo $border
  fi
}

# checks if eth0 has inet
check_eth0=`ifconfig eth0 | grep inet`
if [[ ! $check_eth0 ]]
then
  label_title "eth0 not connected"
  exit 1
else
  label_title "eth0 connected"
fi

###########
# updates #
###########

label_title "updating repos: start"
sudo apt update
check_exit "updating repos:"

label_title "upgrading packages: start"
sudo apt upgrade -y
check_exit "upgrading packages:"

label_title "removing old packages: start"
sudo apt autoremove -y
check_exit "removing old packages:"

#####################
# Installs programs #
#####################

label_title "Installing dnsmasq: start"
sudo apt install -y dnsmasq
check_exit "Installing dnsmasq:"

label_title "Installing hostapd: start"
sudo apt install -y hostapd
check_exit "Installing hostapd:"

################
# Setup script #
################

label_title "stopping dnsmasq: start"
sudo systemctl stop dnsmasq
check_exit "stopping dnsmasq:"

label_title "stopping hostapd: start"
sudo systemctl stop hostapd
check_exit "stopping hostapd:"

# appends config for dhcpcd
label_title "modifying dhcpcd.conf: start"
sudo printf 'interface wlan0\n\tstatic ip_address=192.168.4.1/24\n\tnohook wpa_supplicant' >> /etc/dhcpcd.conf
check_exit "modifying dhcpcd.conf:"

label_title "restarting dhcpcd: start"
sudo service dhcpcd restart
check_exit "restarting dhcpcd:"

# appends config for dnsmasq
label_title "Appending dnsmasq.conf: start"
sudo echo 'interface=wlan0' >> /etc/dnsmasq.conf
quiet_check_exit
sudo echo 'dhcp-range=192.168.4.2,192.168.4.20,255.255.255.0,6h' >> /etc/dnsmasq.conf
check_exit "Appending dnsmasq.conf:"

label_title "starting dnsmasq service: start"
sudo systemctl start dnsmasq
check_exit "starting dnsmasq service:"

# setting up hostapd config
label_title "Creating hostapd.conf: start"
sudo echo "interface=wlan0" > /etc/hostapd/hostapd.conf
quiet_check_exit
sudo echo "driver=nl80211" >> /etc/hostapd/hostapd.conf
quiet_check_exit
sudo echo "ssid=ExamNet" >> /etc/hostapd/hostapd.conf
quiet_check_exit
sudo echo "hw_mode=g" >> /etc/hostapd/hostapd.conf
quiet_check_exit
sudo echo "channel=7" >> /etc/hostapd/hostapd.conf
quiet_check_exit
sudo echo "wmm_enabled=0" >> /etc/hostapd/hostapd.conf
quiet_check_exit
sudo echo "macaddr_acl=0" >> /etc/hostapd/hostapd.conf
quiet_check_exit
sudo echo "auth_algs=1" >> /etc/hostapd/hostapd.conf
quiet_check_exit
sudo echo "ignore_broadcast_ssid=0" >> /etc/hostapd/hostapd.conf
quiet_check_exit
sudo echo "wpa=2" >> /etc/hostapd/hostapd.conf
quiet_check_exit
sudo echo "wpa_passphrase=supersecretpassword" >> /etc/hostapd/hostapd.conf
quiet_check_exit
sudo echo "wpa_key_mgmt=WPA-PSK" >> /etc/hostapd/hostapd.conf
quiet_check_exit
sudo echo "wpa_pairwise=TKIP" >> /etc/hostapd/hostapd.conf
quiet_check_exit
sudo echo "rsn_pairwise=CCMP" >> /etc/hostapd/hostapd.conf
check_exit "Creating hostapd.conf:"

# add pointer for hostapd to hostapd.conf
# DAEMON_CONF is being depreciated, must migrate to new system.\
# recently changed to sed, untested, might not work
label_title "Appending hostapd.conf reference to default/hostapd: start"
sed -i 's/^#DAEMON_CONF=""/DAEMON_CONF="/etc/hostapd/hostapd.conf"' /etc/default/hostapd
check_exit "Appending hostapd.conf reference to default/hostapd:"

label_title "Unmasking, enabling, and starting hostapd: start"
sudo systemctl unmask hostapd
quiet_check_exit
sudo systemctl enable hostapd
quiet_check_exit
sudo systemctl start hostapd
check_exit "Unmasking, enabling, and starting hostapd:"

# enables port forwarding over ipv4
label_title "Uncommenting ipv4 forwarding in sysctl.conf: start"
sed -i '/^#net.ipv4.ip_forward=1/s/^#//' /etc/sysctl.conf
check_exit "Uncommenting ipv4 forwarding in sysctl.conf:"

# setup iptables
# doesn't work completely: need to run these commands every time system boots
label_title "setting up routing in iptables: start"
sudo iptables -t nat -A  POSTROUTING -o eth0 -j MASQUERADE
quiet_check_exit
sudo sh -c "iptables-save > /etc/iptables.ipv4.nat"
quiet_check_exit
# Fails, cuz MASQUERADE requires legacy iptables
iptables-restore < /etc/iptables.ipv4.nat
check_exit "setting up routing in iptables:"

label_title "Done!"
exit 0

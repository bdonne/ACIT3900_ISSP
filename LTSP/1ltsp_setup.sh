#!/bin/sh
apt update && apt upgrade
apt purge --yes --auto-remove indicator-application mate-hud snapd
apt install --yes synaptic
add-apt-repository ppa:ltsp
apt update
apt install --install-recommends ltsp ipxe dnsmasq nfs-kernel-server openssh-server squashfs-tools ethtool net-tools epoptes
gpasswd -a user epoptes
echo 'Use nm-connection-editor to configure the internal network interface to have a static IP for the clients to connect to; then use the 2nd setup file'
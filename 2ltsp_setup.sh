ltsp dnsmasq --proxy-dhcp=0
ltsp image /
ltsp ipxe
ltsp initrd
echo 'Server setup complete, be sure to copy the dnsmasq.conf file to /etc/dnsmasq.d/'
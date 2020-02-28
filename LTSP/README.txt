UBUNTU LTSP SETUP:
1. Copy the LTSP folder to an Ubuntu 18.04 or later image.

2. Switch user to root.

3. Run the 1ltsp_setup script.

4. Use nm-connection-editor to edit your external connection (interface to the internet) and your internal network interface (interface to your future clients).
  For the External connection:
Click on the IPv4 Settings tab. Choose 'Automatic (DHCP) addresses only' instead of just 'Automatic (DHCP)'. In the DNS servers field enter 127.0.0.1 first to allow dnsmasq to cache (otherwise leave it out) followed by one or two external DNS servers, separated by spaces (e.g. 127.0.0.1 208.67.222.222 8.8.8.8). Now click on the General tab and make sure that both lines are enabled: "Connect automatically with priority" and "All users may connect to this network" then save these settings and close the window.
  For the Internal connection:
Click on the IPv4 Settings tab. Choose the method 'Shared to other computers’ and in the ‘Address (optional) section add the address 10.10.10.1 and netmask 24 but leave the gateway blank. Now click on the General tab and make sure that both lines are enabled: "Connect automatically with priority" and "All users may connect to this network" Save these settings and close the window.

5. Run the 2ltsp_setup script.

6. Copy the ltsp-dnsmasq.conf file to the /etc/dnsmasq.d/ folder.

Setup is complete.

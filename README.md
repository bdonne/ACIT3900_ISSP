# ACIT3900_ISSP
Restricted Boot Resource

REQUIREMENTS:
The preseed file is compatible with amd64 debian which can be obtained from https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/ , download the debian-10.2.0-amd64-xfce-CD-1.iso file (639M)

The script file currently only runs on Debian distributions.

DEBIAN PRESEED PROCESS:

Place the preseed file, the script file, and the iso file you downloaded together into a directory of your choice.

Use a Debian Linux interpreter to run the script.sh file (i.e. run ./script.sh from the directory)

The script file will extract the iso image, edit it, then repack it into a new iso image with the preseed embedded. The new iso image may then be used to install debian.

UBUNTU LTSP SETUP:
To setup the Ubuntu LTSP service on Ubuntu you must first login to the root user. You may then run the 1ltsp_setup script.
Once this script is complete you must use nm-connection-editor to edit your external connection (interface to the internet) and your internal network interface (interface to your future clients).
For the External connection:
Click on the IPv4 Settings tab. Choose 'Automatic (DHCP) addresses only' instead of just 'Automatic (DHCP)'. In the DNS servers field enter 127.0.0.1 first to allow dnsmasq to cache (otherwise leave it out) followed by one or two external DNS servers, separated by spaces (e.g. 127.0.0.1 208.67.222.222 8.8.8.8). Now click on the General tab and make sure that both lines are enabled: "Connect automatically with priority" and "All users may connect to this network" then save these settings and close the window.
For the Internal connection:
Click on the IPv4 Settings tab. Choose the method 'Shared to other computers’ and in the ‘Address (optional) section add the address 10.10.10.1 and netmask 24 but leave the gateway blank. Now click on the General tab and make sure that both lines are enabled: "Connect automatically with priority" and "All users may connect to this network" Save these settings and close the window.

Run the 2ltsp_setup script, then copy the ltsp-dnsmasq.conf file to the /etc/dnsmasq.d/ folder.

Setup is complete.
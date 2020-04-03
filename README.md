# ACIT3900_ISSP
Restricted Boot Resource
Authors: Brian Donnally, JiaJun Cai, Zachary Johnston, Pavan Josan, Abdullah Abdullah, Ellery Lee

This Repo contains different resources for generating a USB Boot for BCIT Students to take online exams on their personal computers where access to local resources is completely restricted. The Kiosk Config sets up a Kiosk on a user account on an Ubuntu image, which can then be placed on a USB. This requires the PC to have a USB boot option enabled in BIOS/UEFI.

The LTSP contains information and scripts to create a Linux Terminal Server from an Ubuntu 18.04 or later image. This image can then serve the Kiosk user account over Ethernet as a netboot option.

The Copy VM Folder contains only a README at this time due to variables required in the script. The variables for the .vdi name and more importantly the device path for the USB cannot be hard coded. The device path for the USB, if scripted incorrectly, could result in severe data loss.

The Packer Automated Install Folder contains a github repo Chef recipe "Bento" acquired from https://github.com/chef/bento. This is the resource we used as a template for our Automated Ubuntu Kiosk builder as we are unfamiliar with doing this ourselves.

The Kiosk_config folder is used in the Packer Automated Install. Currently the Packer install IS NOT COMPLETE.

The Kiosk_config_in_VM is an alternative to the Packer Automated Install. This project folder can be used to turn any Ubuntu VM into a Kiosk, which may then be replicated or turned into a USB.

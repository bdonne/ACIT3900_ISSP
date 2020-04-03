This Packer installation is NOT A FINAL PRODUCT. We are still attempting to fully automate adding the Kiosk scripts.

This is intended to be run on a Linux host system. You are required to have Packer on your system.

The packer.sh file will run Packer and input the appropriate commands to create a VirtualBox VM.

Due to our limited understanding of Packer, the Packer.exe might need to be in the same directory as the Packer.sh script. It would also have to be added to your systems Environment PATH.

This script will take a very long time to run the first time. It will:

1. Download Ubunto iso image.

2. Install Ubuntu iso image onto VirtualBox VM.

3. Configure the VM once installed via SSH and running scripts.

This will generate an .ovf file that is a Kiosk.

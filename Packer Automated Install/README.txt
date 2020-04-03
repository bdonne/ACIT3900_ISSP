This is intended to be run on a Linux host system. You are required to have Packer on your system.

The packer.sh file will run Packer and input the appropriate commands to create a VirtualBox VM.

This script will take a very long time to run the first time. It will:

1. Download Ubunto iso image.

2. Install Ubuntu iso image onto VirtualBox VM.

3. Configure the VM once installed via SSH and running scripts.

This will generate an .ovf file that is a Kiosk.

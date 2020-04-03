1. To copy a Virtual Box VM (for example our Kiosk) to a Bootable USB Drive you must navigate to Oracle VirtualBox Directory.

    In the VirtualBox Directory is the VBoxManage.exe file. When in this file path you are able to run vboxmanage command line tools.

2. Use vboxmanage list hdds to show all of the hard drives available for you to use.

    Identify the HDD with the Kiosk.

3. Use vboxmanage clonemedium --format RAW "ABSOLUTE PATH\<hddname>.vdi" "ABSOLUTE PATH\<hddname>.img"

4. Identify the location of your USB device in /dev/ using ls -l /dev/disk/by-id/*usb*

    This will likely be /dev/sdb unless you have multiple devices on your computer.

    BE CERTAIN THE DEVICE IS CORRECT, as all information on it will be destroyed.

5. Unmount the drive with umount /dev/sdb

    Where sdb is the device location for USB

6. Use sudo dd if=<hddname>.img of=/dev/sdb

    'if' is for the input file, so you are inputing the new .img file you made earlier
    'of' is the output or destination, which is the path to your USB drive.

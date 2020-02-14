#!/bin/sh
echo "Checking for packages"
sudo apt update && sudo apt upgrade
sudo apt install xorriso
sudo apt install isohybrid
sudo apt install isolinux
sudo apt install bsdtar
mkdir isofiles
bsdtar -xf debian-10.2.0-amd64-xfce-CD-1.iso -C isofiles
chmod +w -R isofiles/install.amd/
gunzip isofiles/install.amd/initrd.gz
echo preseed.cfg | cpio -H newc -o -A -F isofiles/install.amd/initrd
gzip isofiles/install.amd/initrd
chmod -w -R isofiles/install.amd/
cd isofiles
chmod +w md5sum.txt
md5sum `find -follow -type f` > md5sum.txt
chmod -w md5sum.txt
cd ..
xorriso -as mkisofs -o preseed-debian-10.2.0-i386-netinst.iso \
	        -isohybrid-mbr /usr/lib/ISOLINUX/isohdpfx.bin \
		        -c isolinux/boot.cat -b isolinux/isolinux.bin -no-emul-boot \
			        -boot-load-size 4 -boot-info-table isofiles
sudo rm -r isofiles
echo "Preseed Image Created"


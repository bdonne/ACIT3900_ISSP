# ACIT3900_ISSP
Restricted Boot Resource

REQUIREMENTS:
The preseed file is compatible with amd64 debian which can be obtained from https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/ , download the debian-10.2.0-amd64-xfce-CD-1.iso file (639M)

Linux interpreter to run the Script file.

PROCESS:

Place the preseed file, the script file, and the iso file you downloaded into a directory of your choice.

The script file will extract the iso image, edit it, then repack it into a new iso image with the preseed embedded. The new iso image may then be used to install debian.
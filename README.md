# ACIT3900_ISSP
Restricted Boot Resource

The preseed file is compatible with amd64 debian which can be obtained from https://www.debian.org/CD/http-ftp/
The official CD image is the .iso used

Once you have the .iso image you must mount it and extract all the files to a directory and name the directory "isofiles"

Place the preseed file, the script file, and the isofiles directory in the same directory to run the script file successfully

The script file will add the preseed file and return a new iso image. This image can be used to install the debian OS.
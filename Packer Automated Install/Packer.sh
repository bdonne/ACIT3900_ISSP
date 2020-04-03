
#Packer must be installed and be added to system Path for this to work
cd /ACIT_3900/bento-master/packer-temples/ubuntu/
packer build -only=virtualbox-iso ubuntu-19.10-amd64.json

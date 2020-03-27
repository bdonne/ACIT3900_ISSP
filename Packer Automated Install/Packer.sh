
#Add directory to PATH
echo 'PATH="~/ACIT_3900/":${PATH}' >> ~./bashrc
echo ''
#Run Packer
cd /ACIT_3900/bento-master/packer-temples/ubuntu/
packer build -only=virtualbox-iso ubuntu-19.10-amd64.json
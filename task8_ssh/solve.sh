#install open-ssh server 
sudo apt-get install openssh-server
sudo systemctl enable ssh
sudo systemctl start ssh
#on client generate keys
ssh-keygen -t rsa
# copy ssh-key to server
ssh-copy-id lera@192.168.1.1
#check
ssh lera@192.168.1.1



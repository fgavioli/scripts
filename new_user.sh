#!/usr/bin/env bash
set -eux

username=$1
pkey=$2

sudo adduser $username
sudo passwd --expire $username
sudo usermod -aG sharedUsers $username
sudo mkdir /home/$username/.ssh
echo "$pkey" | sudo tee -a /home/$username/.ssh/authorized_keys
sudo chown $username:$username -R /home/$username/.ssh
sudo chmod 700 -R /home/$username/.ssh
sudo systemctl restart sshd


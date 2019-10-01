#!/bin/bash
##################################################
# Install SSH-server & sudo                      #
# Author by Dethroner, 2019                      #
################################################## 

### Install
echo "Install SSH-server & sudo"
apt -y install openssh-server sudo

### Add SSH key
echo "Add SSH key"
mkdir /home/$username/.ssh
echo $ssh_key > /home/$username/.ssh/authorized_keys
chmod 640 /home/$username/.ssh/*
chown -R $username:$username /home/$username/.ssh

### Add User in sudo
echo "Add User in sudo"
echo "$username  ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

### Edit SSH-server configuration
echo "Edit SSH-server configuration"
sed -i '
/#ListenAddress ::/c Protocol 2
/#SyslogFacility/c SyslogFacility AUTH
/#StrictModes/c StrictModes yes
/#PermitRootLogin/c PermitRootLogin no
/#PubkeyAuthentication/c PubkeyAuthentication yes
/#AuthorizedKeysFile/c AuthorizedKeysFile %h/.ssh/authorized_keys
/#PasswordAuthentication/c PasswordAuthentication no
/#PermitEmptyPasswords/c PermitEmptyPasswords no
' /etc/ssh/sshd_config

### Restart SSH-server
echo "Restart SSH-server"
/etc/init.d/ssh restart
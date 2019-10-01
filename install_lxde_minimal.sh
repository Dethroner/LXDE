#!/bin/bash
##################################################
# Install LXDE minimal                           #
# Author by Dethroner, 2019                      #
################################################## 

#################################################################################
echo "Install LXDE on minimal configuration..."
apt -y install lxde-core lxinput lxappearance lxappearance-obconf network-manager nm-tray network-manager-gnome gnome-disk-utility gnome-system-tools usermode

sed -i '/managed=false/c managed=true' /etc/NetworkManager/NetworkManager.conf
sed -i '
s/allow-hotplug e/#allow-hotplug e/g
s/iface e/#iface e/g
' /etc/network/interfaces

sed -ie '
/\/ThemeName*=/ s|=.*$|=Adwaita-dark|
/\/IconThemeName*=/ s|=.*$|=nuoveXT2|
' /home/$username/.config/lxsession/LXDE/desktop.conf

/etc/init.d/lightdm start

#################################################################################
# echo "Tweake lightdm..."
# echo 'deb http://download.opensuse.org/repositories/home:/antergos/Debian_9.0/ /' > /etc/apt/sources.list.d/home:antergos.list
# wget -nv https://download.opensuse.org/repositories/home:antergos/Debian_9.0/Release.key -O Release.key
# apt-key add - < Release.key
# apt-get update
# apt-get install lightdm-webkit2-greeter

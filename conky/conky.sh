#!/bin/bash
##################################################
# Install Conky                                  #
# Author by Dethroner, 2019                      #
################################################## 

#################################################################################
echo "Install LXDE on minimal configuration..."
apt -y install conky conky-all

#################################################################################
cp $pwd/conky/lxde-rc.xml /home/$username/.config/openbox/lxde-rc.xml

cp $pwd/conky/conky.conf /etc/conky

cp $pwd/conky/weather.lua /etc/conky
cp -r $pwd/conky/60x60/ /etc/conky
chown -R nobody:nogroup /etc/conky
chmod -R 777 /etc/conky/60x60

echo "@conky" >> /etc/xdg/lxsession/LXDE/autostart
#!/bin/bash
##################################################
# Main command's script                          #
# Author by Dethroner, 2019                      #
################################################## 

#################################################################################
echo "Start..."

### Vars
export username=dethroner 
export ssh_key="ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAi7In5b1Lt5B6ea+ExDNrGksDZ84SsetdfkBZx5dbFgxMMBjnAOZw7XO4PFb0AJgpa/Dgocqrzd5fWBOl74XJXXz5xX4r7U1OoHEhxkU2kC7dkkBA3Bj8iSPTw8ikCPun8KaHRWId3r0W4NY/Z2Pk4uimKKGOS26nfsbZeGkr931Z2Vq4TjkdIsjPDDz0S/MF4tnBJpq8/Y2qG1GGtTnSk/z0va9qi9mRJn085whyDmOPEMy8tfeZA2soDPGPH+OimzJJM6jtYM4+VCm5crSqrN3Rv3veyBb3yFIKa2umwzex+2H9WebTLTlrD4tAUUYDi9bIwLQLaoWoIEudJbUL+Q== dethroner@tut.by"
export pwd=$(pwd)

### Upgrade distributive (If Debian not 10).
echo "Start upgrade distributive..."
cp $pwd/sources.list /etc/apt
apt update
apt -y dist-upgrade && apt -y upgrade

set -x

echo "Start install..."
### Main
"$pwd/ssh-server.sh"
"$pwd/install_lxde_minimal.sh"
"$pwd/install_soft.sh"
"$pwd/conky/conky.sh"

set +x

apt -y autoremove && apt -y autoclean

/etc/init.d/lightdm start


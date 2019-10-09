# Dethroner
## Install workstation on base LXDE (minimal configure) in Debian.

1. Install base configuration Debian. Login as <b>root</b>.<br>
2. Install Git:
```
apt install git
```
3. Clone repository:
```
cd /tmp
git clone https://github.com/Dethroner/LXDE
chmod -R +x ./LXDE
```
4. Install LXDE vs SSH-server & sudo & conky (Warning, if the username (in the example: dethroner) was not created during installation, then you will need to create a user (**adduser**) with the name as in the configuration (See block vars **main.sh**)):
```
cd ./LXDE
sh main.sh
```

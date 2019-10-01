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
4. Istall LXDE vs SSH-server & sudo & conky:
```
cd ./LXDE
sh main.sh
```
#!/bin/bash

##############################
#          GENERAL           #
##############################
apt install -y open-vm-tools-desktop fuse network-manager-openvpn-gnome

# Tools
apt-get -y install vim tmux htop git curl python-pip rlwrap ncat golang proxychains
pip install pipenv

# Dotfiles
git clone https://github.com/dirtymoe/dotfiles ~/dotfiles
bash ~/dotfiles/install.sh

cd /opt

##############################
#         PENTESTING         #
##############################
# General
apt-get -y install seclists gobuster wpscan bloodhound amass masscan medusa
go get github.com/ffuf/ffuf
go get github.com/sensepost/gowitness
pip install exrex
git clone https://github.com/urbanadventurer/username-anarchy

# Scanners
pip install droopescan
git clone https://github.com/rezasp/joomscan
git clone https://github.com/internetwache/GitTools

# Linux
git clone https://github.com/rebootuser/LinEnum
git clone https://github.com/diego-treitos/linux-smart-enumeration

# Windows
git clone https://github.com/samratashok/nishang
git clone --branch dev https://github.com/PowerShellMafia/PowerSploit
# git clone https://github.com/BC-SECURITY/Empire
go get github.com/ropnop/kerbrute

## Impacket Bleeding Edge
#git clone https://github.com/SecureAuthCorp/impacket
#cd impacket && pipenv install
#pipenv run python ./setup.py build && python ./setup.py install
#cd /opt

## CrackMapExec
apt-get install -y libssl-dev libffi-dev python-dev build-essential
git clone --recursive https://github.com/byt3bl33d3r/CrackMapExec
cd CrackMapExec && pipenv install
pipenv run python setup.py install
cd /opt
ln -s /root/.local/share/virtualenvs/CrackMapExec-*/bin/crackmapexec /usr/local/bin/cme

## Silent Trinity
#git clone https://github.com/byt3bl33d3r/SILENTTRINITY
#cd SILENTTRINITY && pipenv install
#cd /opt



##############################
#        BINARY STUFF        #
##############################
# Tools
apt-get -y install ltrace strace

# Ghidra
apt-get -y install openjdk-11-jdk
wget https://ghidra-sre.org/$(curl -s https://ghidra-sre.org | grep -E --only-matching 'ghidra_.*.zip' | head -n 1)
unzip ghidra*.zip && rm -f ghidra*.zip
mv ghidra* ghidra
ln -s /opt/ghidra/ghidraRun /usr/local/bin/ghidra

# IDA
IDA_VERSION='idafree70_linux.run'
wget https://out7.hex-rays.com/files/$IDA_VERSION
chmod +x $IDA_VERSION && ./$IDA_VERSION --mode unattended && rm -f $IDA_VERSION
rm ~/Desktop/IDA\ Free.desktop
ln -s /opt/idafree-7.0/ida64 /usr/local/bin/ida64

# GEF
wget -O ~/.gdbinit-gef.py -q https://github.com/hugsy/gef/raw/master/gef.py
echo source ~/.gdbinit-gef.py >> ~/.gdbinit

##############################
#            CTFy            #
##############################
apt-get -y install steghide stegosuite
pip install sshuttle pwntools oletools

git clone https://github.com/GDSSecurity/PadBuster

# RsaCtfTool
apt-get -y install libgmp3-dev libmpc-dev
git clone https://github.com/Ganapati/RsaCtfTool
cd RsaCtfTool && pipenv --three install
echo /root/.local/share/virtualenvs/RsaCtfTool-*/bin/python /opt/RsaCtfTool/RsaCtfTool.py > /usr/local/bin/RsaCtfTool
chmod +x /usr/local/bin/RsaCtfTool
cd /opt

# Pspy pre-compiled binaries
PSPY_BASE=https://github.com/DominicBreuker/pspy/releases/download/v1.2.0/
mkdir /opt/pspy
cd /opt/pspy
for i in pspy32 pspy32s pspy64 pspy64s; do
    wget $PSPY_BASE$i /opt/pspy/$i
done
chmod +x pspy*
cd -

echo ''
echo ''
echo '##############################'
echo '#         LEFT TO DO         #'
echo '##############################'
echo ' - Set up Bloodhound'
echo '   \ https://stealingthe.network/quick-guide-to-installing-bloodhound-in-kali-rolling/'
# echo ' - Finish installing Empire'
# echo '   \ cd /opt/Empire && bash setup/install.sh'
echo ' - Install BurpSuite Pro and add Cert to FFX'
echo ''
echo ''

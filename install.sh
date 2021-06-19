#!/bin/bash

if ! [ $(id -u) = 0 ]; then
    echo "This script must be run as root"
    exit 1
fi

# Determine the path of the repository
BASE="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"


# Enable root and set default password
apt-get install -y kali-root-login
echo 'root:a' | chpasswd

# Install i3-gaps w/ dependencies and related tools
apt-get install -y kali-desktop-i3-gaps i3blocks rofi feh compton

# Install general tools
apt-get install -y lxappearance htop neovim

# Install Alacritty if it does not exist
if ! [ -x /usr/local/bin/alacritty ]; then
    # Install dependencies
    apt-get install -y cargo cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev python3

    # Clone and build from source
    git clone https://github.com/jwilm/alacritty /opt/alacritty
    cd /opt/alacritty
    cargo build --release
    cp target/release/alacritty /usr/local/bin
    cd $OLDPWD
fi

# Copy dotfiles, wallpaper and so on
cp -rT $BASE/home $HOME
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install additional tools
# apt
apt-get install -y seclists gobuster httpie chromium eyewitness bloodhound dbeaver pwncat

# pip
apt-get install -y python3 python3-pip python3-venv
pip3 install pipx

pipx install git+https://github.com/cddmp/enum4linux-ng
pipx install git+https://github.com/dirkjanm/adidnsdump
pipx install git+https://github.com/bitsadmin/wesng

# go
apt-get install -y golang

go get github.com/ropnop/kerbrute

# git
cd /opt
git clone https://github.com/diego-treitos/linux-smart-enumeration
git clone https://github.com/carlospolop/privilege-escalation-awesome-scripts-suite
git clone https://github.com/samratashok/nishang

git clone https://github.com/knavesec/Max
ln -s /opt/Max/max /usr/sbin/max
chmod +x /usr/sbin/max

wget https://github.com/ropnop/go-windapsearch/releases/download/v0.3.0/windapsearch-linux-amd64
mv windapsearch-linux-amd64 /usr/local/bin/windapsearch


#!/bin/bash

if ! [ $(id -u) = 0 ]; then
    echo "This script must be run as root"
    exit 1
fi

cd ..
mv kali-postinstall $HOME
cd $HOME
cd kali-postinstall
chown root:root . -R

# Get the root user back
echo "Set the new root password"
passwd
apt-get install -y kali-root-login

# Install i3-gaps and all dependencies/related tools
apt-get install -y kali-desktop-i3-gaps i3blocks rofi feh compton

# Install Alacritty
apt-get install -y cargo cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev python3
git clone https://github.com/jwilm/alacritty
cd alacritty
cargo build --release
cp target/release/alacritty /usr/local/bin
cd ..
rm -rf alacritty

# Copy dotfiles
cp -rT dotfiles $HOME

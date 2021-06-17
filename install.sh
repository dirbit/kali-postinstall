#!/bin/bash

if ! [ $(id -u) = 0 ]; then
    echo "Needs to be run as root"
    exit 1
fi

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

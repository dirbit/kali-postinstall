#!/bin/bash

# Install i3-gaps and all dependencies/related tools
sudo apt-get install -y kali-desktop-i3-gaps i3blocks rofi feh compton

# Install Alacritty
sudo apt-get install -y cargo cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev python3
git clone https://github.com/jwilm/alacritty
cd alacritty
cargo build --release
sudo cp target/release/alacritty /usr/local/bin
cd ..
rm -rf alacritty

# Copy dotfiles
cp -rT dotfiles $HOME

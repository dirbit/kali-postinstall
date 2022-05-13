#!/usr/bin/env bash

git clone https://github.com/vinceliuice/Qogir-theme && \
cd Qogir-theme && \
./install.sh && \
cd ..

git clone https://github.com/vinceliuice/Qogir-icon-theme && \
cd Qogir-icon-theme && \
./install.sh && \
cd ..

xfconf-query -c xfwm4 -p /general/theme -s "Qogir"
xfconf-query -c xsettings -p /Net/ThemeName -s "Qogir"
xfconf-query -c xsettings -p /Net/IconThemeName -s "Qogir-manjaro"


#!/bin/bash

PROFILE=$(gsettings get org.gnome.Terminal.ProfilesList default)
PROFILE=${PROFILE:1:-1} # remove leading and trailing single quotes

gsettings set "org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$PROFILE/" default-size-columns 160
gsettings set "org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$PROFILE/" default-size-rows 42
gsettings set org.gnome.Terminal.Legacy.Settings default-show-menubar false

gsettings set org.gnome.desktop.lockdown disable-lock-screen true
gsettings set org.gnome.desktop.screensaver lock-enabled false
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout 0
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-timeout 0
gsettings set org.gnome.desktop.session idle-delay 0


apt-get install -y gnome-shell-extension-dash-to-panel
gnome-shell-extension-tool -e dash-to-panel@jderose9.github.com
gnome-shell-extension-tool -d dash-to-dock@micxgx.gmail.com
gnome-shell-extension-tool -e alternate-tab@gnome-shell-extensions.gcampax.github.com
gsettings set org.gnome.shell.extensions.dash-to-panel panel-size 26
gsettings set org.gnome.mutter center-new-windows true

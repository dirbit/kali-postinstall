#!/usr/bin/env bash


# apt

apt-get update
apt-get upgrade -y


# pipx

pipx upgrade-all


# go

gup update


# git

for d in /opt/*/; do
    [ ! -d "$d/.git" ] && continue

    echo "Pulling $(basename $d)"
    git -C "$d" pull
done


# custom

wpscan --update
nuclei --update-templates


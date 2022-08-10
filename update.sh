#!/usr/bin/env bash

# https://serverfault.com/a/227194
export DEBIAN_FRONTEND=noninteractive

# apt

apt-get update
apt-get upgrade -yq


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


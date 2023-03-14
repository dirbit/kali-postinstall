#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# https://serverfault.com/a/227194
export DEBIAN_FRONTEND=noninteractive

# apt

list_apt=(
    open-vm-tools
    open-vm-tools-desktop
    kali-tweaks
    kali-defaults
    
    vim
    htop
    curl
    git
    tmux
    chromium
    openssl
    python2  # sadge
    python3
    python3-pip
    python3-venv
    golang
    binutils
    dnsutils  # for dig
    smbclient
    default-mysql-client
    postgresql-client-common
    docker.io
    libreoffice
    sqlitebrowser
    xtightvncviewer
    thunderbird
    pst-utils
    ripgrep
    freerdp2-x11  # pass the hash rdp
    wireguard
    resolvconf  # wireguard

    nikto
    dnsrecon
    subfinder
    dos2unix
    python3-impacket
    impacket-scripts
    metasploit-framework
    feroxbuster
    ncat
    socat
    amass
    hydra
    smbmap
    wpscan
    swaks
    ysoserial
    bettercap
    proxychains
    nmap
    masscan
    responder
    john
    ismtp
    httpie
    wordlists
    seclists
    gobuster
    ffuf
    eyewitness
    bloodhound
    dbeaver
    ghidra
    wireshark
    apktool
    sqlmap
    exploitdb
    windows-binaries

    libxml2-dev  # pywsus
    libxslt-dev  # pywsus
    libffi-dev  # pyenv/python
    libpcap-dev  # PCredz
    libssl-dev  # DonPAPI
    swig  # DonPAPI
    jadx  # apkleaks
    libkrb5-dev  # pyverview
)

apt-get update && \
apt-get upgrade -yq && \
apt-get autoremove -yq

for p in "${list_apt[@]}"; do
    apt-get install -yq $p
done


# pip

list_pip=(
    dsinternals  # impacket-ntlmrelayx
)

for p in "${list_pip[@]}"; do
    python3 -m pip install $p
done


# pipx

list_pipx=(
    pipenv
    poetry
    ssh-audit
    apkleaks
    powerhub

    git+https://github.com/byt3bl33d3r/CrackMapExec
    git+https://github.com/Hackndo/lsassy
    git+https://github.com/dirkjanm/adidnsdump
    git+https://github.com/skelsec/pypykatz
    git+https://github.com/fox-it/BloodHound.py
    git+https://github.com/sshuttle/sshuttle
    git+https://github.com/cddmp/enum4linux-ng
    git+https://github.com/ly4k/Certipy
    git+https://github.com/the-useless-one/pywerview
    git+https://github.com/login-securite/DonPAPI
    git+https://github.com/p0dalirius/Coercer
)

python3 -m pip install --upgrade pip
python3 -m pip install pipx

for p in "${list_pipx[@]}"; do
    pipx install $p
done


# go

list_go=(
    github.com/nao1215/gup@latest
    github.com/jpillora/chisel@latest
    github.com/ropnop/kerbrute@latest
    github.com/sensepost/gowitness@latest
    github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest
    github.com/RedTeamPentesting/pretender@latest
)

for p in "${list_go[@]}"; do
    go install -v $p
done


# git

list_git=(
    https://github.com/GoSecure/pywsus
    https://github.com/internetwache/GitTools
    https://github.com/itm4n/PrivescCheck
    https://github.com/diego-treitos/linux-smart-enumeration
    https://github.com/carlospolop/privilege-escalation-awesome-scripts-suite
    https://github.com/lgandx/PCredz
    https://github.com/knavesec/Max
)

cd /opt
for p in "${list_git[@]}"; do
    git clone $p
done


# special stuff

ln -s "$SCRIPT_DIR/.aliases" ~/.aliases

cd /usr/share/wordlists
[ -f rockyou.txt ] || gunzip rockyou.txt.gz

# add flags to chromium so it works (TM)
CHROMIUM_FLAGS='export CHROMIUM_FLAGS="$CHROMIUM_FLAGS --no-sandbox --disable-xss-auditor"'
CHROMIUM_FLAGS_FILE=/etc/chromium.d/default-flags

if ! grep -Fxq "$CHROMIUM_FLAGS" "$CHROMIUM_FLAGS_FILE"; then
    echo "$CHROMIUM_FLAGS" >> "$CHROMIUM_FLAGS_FILE"
fi

ln -s /opt/Max/max.py /usr/sbin/max && \
chmod +x /usr/sbin/max

# install pip for python2
if ! command -v pip2 &> /dev/null; then
    curl https://bootstrap.pypa.io/pip/2.7/get-pip.py | python2 -
fi

# fix adidnsdump - install requirement that isn't listed
/root/.local/pipx/venvs/adidnsdump/bin/python -m pip install pycryptodome

# fix pywerview - install dsinternals (upstream bug from impacket)
/root/.local/pipx/venvs/pywerview/bin/python -m pip install dsinternals

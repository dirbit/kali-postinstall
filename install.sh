#!/usr/bin/env bash


SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )


# apt

list_apt=(
    open-vm-tools
    open-vm-tools-desktop
    kali-tweaks
    
    vim
    htop
    curl
    git
    tmux
    chromium
    openssl
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
    freerdp2-x11  # pass the hash rdp

    libffi-dev  # pyenv/python
    libpcap-dev  # PCredz
    libssl-dev  # DonPAPI
    swig  # DonPAPI
)

apt-get update && \
apt-get upgrade -y && \
apt-get autoremove -y

for p in "${list_apt[@]}"; do
    apt-get install -y $p
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

    git+https://github.com/byt3bl33d3r/CrackMapExec
    git+https://github.com/Hackndo/lsassy
    git+https://github.com/dirkjanm/adidnsdump
    git+https://github.com/skelsec/pypykatz
    git+https://github.com/fox-it/BloodHound.py
    git+https://github.com/sshuttle/sshuttle
    git+https://github.com/cddmp/enum4linux-ng
    git+https://github.com/ly4k/Certipy
    git+https://github.com/AdrianVollmer/PowerHub
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
    https://github.com/login-securite/DonPAPI
    https://github.com/knavesec/Max
)

cd /opt
for p in "${list_git[@]}"; do
    git clone $p
done


# special stuff

ln -s "$SCRIPT_DIR/.aliases" ~/.aliases

cd /usr/share/wordlists
gunzip rockyou.txt.gz

# add flags to chromium so it works (TM)
echo 'export CHROMIUM_FLAGS="$CHROMIUM_FLAGS --no-sandbox --disable-xss-auditor"' >> /etc/chromium.d/default-flags

ln -s /opt/Max/max.py /usr/sbin/max && \
chmod +x /usr/sbin/max


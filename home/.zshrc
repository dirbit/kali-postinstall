# oh my zsh
export ZSH=~/.oh-my-zsh

ZSH_THEME=gentoo

plugins=(
    docker
    docker-compose
    git
    pipenv
    extract
)

DISABLE_AUTO_UPDATE="true"
source $ZSH/oh-my-zsh.sh

# Additional Stuff
export GOPATH=$HOME/go
export LOCALBIN=$HOME/.local/bin
export PATH=$PATH:$LOCALBIN:$GOPATH/bin
export EDITOR="nvim"

alias vim="nvim"
alias ll="ls -lah"

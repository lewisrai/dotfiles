alias ls='eza -al --colour=auto --group-directories-first --icons'
alias grep='grep --colour=auto'

alias snvim='sudo nvim --clean'
alias update='sudo pacman -Syu'

restart() {
    killall "$1"
    "$1" & disown
}

PS1='[\u@\h \W]\$ '

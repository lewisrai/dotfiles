alias grep='grep --color=auto'
alias ls='ls -A -l --color=auto --group-directories-first'

alias snvim='sudo nvim --clean'
alias update='sudo pacman -Syu'

restart() {
    killall "$1"
    "$1" & disown
}

PS1='[\u@\h \W]\$ '

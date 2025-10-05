alias grep='grep --color=auto'
alias ls='ls -A -l --color=auto --group-directories-first'

alias snvim='sudo nvim --clean'

alias install='sudo pacman -S'
alias remove='sudo pacman -Rsn'
alias update='sudo pacman -Syu'

export PATH="$PATH:~/Apps/matlab2024b/bin/"

clean() {
    rm -rf ~/.cache/*
    rm -f ~/.bash_history
}

restart() {
    killall "$1"
    "$1" & disown
}

PS1='\e[1;35m[\u@\h \W]\$\e[m '

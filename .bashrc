alias grep='grep --color=auto'
alias ls='ls -A -l --color=auto --group-directories-first'


alias install='paru -Syu'
alias remove='paru -Rsn'
alias update='paru -Syu'

alias clean='rm -rf ~/.bun ~/.cache/ ~/.cargo/ ~/.mono/ ~/.nv/ ~/.texlive/; history -c; paru -Scc --noconfirm;'
alias testmon='sleep 3 && hyprctl monitors'
alias scx='pkexec systemctl enable scx_loader.service'
alias gpum='supergfxctl -g'

alias bun='bun --bun'
alias bunx='bunx --bun'
alias snvim='sudo nvim --clean'

alias gemmal='llama-server --threads 6 --ctx-size 4096 --mlock --no-mmap --model ~/documents/gemma4 --temp 1.0 --top-k 64 --top-p 0.95 --ctx-checkpoints 0 --checkpoint-every-n-tokens -1'
alias gemmam='llama-server --threads 6 --ctx-size 8192 --mlock --no-mmap --model ~/documents/gemma4 --temp 1.0 --top-k 64 --top-p 0.95 --ctx-checkpoints 0 --checkpoint-every-n-tokens -1'
alias gemmah='llama-server --threads 6 --ctx-size 16384 --mlock --no-mmap --model ~/documents/gemma4 --temp 1.0 --top-k 64 --top-p 0.95 --ctx-checkpoints 0 --checkpoint-every-n-tokens -1'

restart() {
    pkill "$1" && "$1" & disown
}

timer() {
    case $1 in
        's') source ~/timer-stretch.sh;;
        'w') source ~/timer-workout.sh;;
        *) echo 'invalid'; return 0;;
    esac

    for action in "${actions[@]}"; do
        IFS=' '; words=($action); unset IFS

        for (( i=words[0]; i>=1; i-- )); do
            text="$i ${words[@]:1}"

            if [ $i -gt 6 ]; then
                notify-send -h string:x-dunst-stack-tag:timer "$text"
            else
                notify-send -h string:x-dunst-stack-tag:timer -u critical "$text"
            fi

            sleep 1
        done
    done
}

PS1='\[\e[1;35m\][\u@\h \W]\$\[\e[m\] '

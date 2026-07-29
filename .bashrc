alias grep='grep --color=auto'
alias ls='ls -A -l --color=auto --group-directories-first'

alias install='sudo pacman -Syu'
alias remove='sudo pacman -Rsn'
alias update='sudo pacman -Syu'

alias clean='rm -rf ~/.bun ~/.cache/ ~/.cargo/ ~/.npm/ ~/.nv/ ~/.pki/ ~/.texlive/; history -c; sudo pacman -Scc --noconfirm;'
alias gpum='supergfxctl -g'

alias bun='bun --bun'
alias bunx='bunx --bun'
alias snvim='sudo nvim --clean'

alias gemma31='llama-server --threads 6 --ctx-size 16384 --parallel 1 --mlock --no-mmap --model ~/documents/gemma31 --temp 1.0 --top-k 64 --top-p 0.95 --checkpoint-every-n-tokens -1 --cache-ram 0'

alias qmlformat='/usr/lib/qt6/bin/qmlformat -n -S --objects-spacing --functions-spacing'

restart() { pkill "$1"; "$@" & disown; }

timer() {
    case $1 in
        s) source ~/timer-s.sh;;
        w) source ~/timer-w.sh;;
        *) return;;
    esac

    for action in "${actions[@]}"; do
        set -- $action

        for (( i=$1; i>=1; i-- )); do
            if (( i > 6 )); then
                notify-send -h string:tag:timer "$i ${*:2}"
            else
                notify-send -h string:tag:timer -u critical "$i ${*:2}"
            fi

            sleep 1
        done
    done
}

PS1='\[\e[1;35m\][\u@\h \W]\$\[\e[m\] '

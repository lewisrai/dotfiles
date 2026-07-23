alias grep='grep --color=auto'
alias ls='ls -A -l --color=auto --group-directories-first'

alias parui='paru -Syu'
alias parur='paru -Rsn'

alias clean='rm -rf ~/.bun ~/.cache/ ~/.cargo/ ~/.npm/ ~/.nv/ ~/.pki/ ~/.texlive/; history -c; paru -Scc --noconfirm;'
alias gpum='supergfxctl -g'

alias bun='bun --bun'
alias bunx='bunx --bun'
alias snvim='sudo nvim --clean'

alias gemma31='llama-server --threads 6 --ctx-size 16384 --parallel 1 --mlock --no-mmap --model ~/documents/gemma31 --temp 1.0 --top-k 64 --top-p 0.95 --checkpoint-every-n-tokens -1 --cache-ram 0'

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
                notify-send -h string:tag:timer "$text"
            else
                notify-send -h string:tag:timer -u critical "$text"
            fi

            sleep 1
        done
    done
}

PS1='\[\e[1;35m\][\u@\h \W]\$\[\e[m\] '

# Setup fzf
# ---------
if [[ ! "$PATH" == */home/diego/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/diego/.fzf/bin"
fi

export FZF_DEFAULT_OPTS='
--preview-window="right:50%:wrap"
--preview "
    if [ -d {} ]; then
        ls -la --color=always {}
    elif [ -f {} ]; then
        if file --mime {} | grep -q text; then
            bat --color=always --style=numbers --line-range :500 {} 2>/dev/null || cat {}
        else
            file {}
        fi
    else
        echo {} | fold -s -w \$(tput cols)
    fi
"
--bind "up:preview-up,down:preview-down"
'

source <(fzf --zsh)

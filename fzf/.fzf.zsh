# Setup fzf
# ---------
if [[ ! "$PATH" == */home/diego/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/diego/.fzf/bin"
fi

source <(fzf --zsh)

source ~/.asdf/asdf.fish

alias c="clear"

set --export FZF_DEFAULT_OPTS "--height 40% --layout=reverse --border"
set --export FZF_DEFAULT_COMMAND "fdfind --hidden --exclude '.git'"
set --export GOPATH $HOME/.local/go
set --export PYTHON3_PATH (asdf where python 3.9.1)/bin/python
set PATH $HOME/.local/bin $GOPATH/bin $PATH
set --export EDITOR nvim
eval (direnv hook fish)

function fzf_select_history
    history | fzf --no-sort +m --query "$LBUFFER" --prompt="History > " | read select
    if [ $select ]
        commandline $select
    else
        commandline ''
    end
end
alias g='cd (ghq list -p | fzf --prompt "Project > ")'
alias cdp='cd (ghq root)/github.com/ryutah'
bind -s \cr fzf_select_history

alias bat="batcat"
alias fd="fdfind"

alias podman="podman --events-backend=file"
alias docker="podman"

function ide
    tmux split-window -v -p 30
    tmux split-window -h
    tmux select-pane -t 1
    nvim $1
end

source ~/.asdf/asdf.fish

alias c="clear"

set --export FZF_DEFAULT_OPTS "--height 40% --layout=reverse --border"
set --export FZF_DEFAULT_COMMAND "fdfind -H -E .git"
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
alias k="kubectl"
alias gc="gcloud beta interactive"

function ide
    tmux split-window -v -p 30
    tmux split-window -h
    tmux select-pane -t 1
    nvim $1
end

if [ -x $HOME/.local/google-cloud-sdk ]
    source $HOME/.local/google-cloud-sdk/path.fish.inc
end

set -gx PATH $PATH $HOME/.krew/bin

. ~/.asdf/plugins/java/set-java-home.fish
set -gx fish_user_paths $fish_user_paths $HOME/.cargo/bin

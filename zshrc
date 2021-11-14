# Set up the prompt

autoload -Uz promptinit
promptinit
prompt adam1

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit's installer chunk
#
# Install Plugins
zinit light zdharma/history-search-multi-word
zinit light zsh-users/zsh-syntax-highlighting
zinit ice depth=1; zinit light romkatv/powerlevel10k
zinit ice blockf
zinit light zsh-users/zsh-completions
# see:
#   - https://zenn.dev/xeres/articles/2021-05-05-understanding-zinit-syntax
#   - https://blog.katio.net/page/zplugin
zinit ice wait lucid atload'_zsh_autosuggest_start'
zinit light zsh-users/zsh-autosuggestions
zinit ice as"completion" cp"gibo-completion.zsh -> _gibo"
zinit snippet https://github.com/simonwhitaker/gibo/blob/master/shell-completions/gibo-completion.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# fzf_select_history is open command history with fzf
fzf_select_history() {
    BUFFER=$(history -n -r 1 | fzf --no-sort +m --query "$LBUFFER" --prompt="History > ")
    CURSOR=$#BUFFER
}

# ide is open neovim with terminal split
ide() {
    tmux split-window -v -p 30
    tmux split-window -h
    tmux select-pane -t 1
    nvim $1
}

# command history fazzy find
zle -N fzf_select_history
bindkey '^r' fzf_select_history

# Google Cloud SDK
if [[ -x ${HOME}/.local/google-cloud-sdk ]]; then
    source ${HOME}/.local/google-cloud-sdk/path.zsh.inc
    source ${HOME}/.local/google-cloud-sdk/completion.zsh.inc
fi

# asdf config
source ${HOME}/.asdf/asdf.sh
# append completions to fpath
fpath=(${ASDF_DIR}/completions $fpath)

# environment variables
export GOPATH=${HOME}/.local/go
export PATH=${HOME}/.cargo/bin:${HOME}/.krew/bin:${HOME}/.local/bin:${GOPATH}/bin:${PATH}
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border"
export FZF_DEFAULT_COMMAND="fd -H -E .git"
export PYTHON3_PATH=$(asdf where python)/bin/python
export EDITOR=nvim
# to be remove before slash with <ctrl+w>
# see: https://cameong.hatenablog.com/entry/20140321/1395377298
export WORDCHARS='*?_.[]~=&;!#$%^(){}<>'

# direnv setup
eval "$(direnv hook zsh)"

# adds fpath
my_completions=${HOME}/.local/share/zsh/completions
if [[ ! -d ${my_completions} ]]; then
    mkdir -p ${my_completions}
fi
# enable gh completion
if which gh > /dev/null 2>&1 && [[ ! -f ${my_completions}/_gh ]]; then
    gh completion -s zsh > ${my_completions}/_gh
fi
# enable rustup completion
if which rustup > /dev/null 2>&1 && [[ ! -f ${my_completions}/_rustup ]]; then
    rustup completions zsh > ${my_completions}/_rustup
    cat ${HOME}/.rustup/toolchains/$(rustup default | grep default | sed -E 's/^(.+)\s\(default\)$/\1/')/share/zsh/site-functions/_cargo > ${my_completions}/_cargo
fi
# enable kubectl completion
if which kubectl > /dev/null 2>&1 && [[ ! -f ${my_completions}/_kubectl ]]; then
    kubectl completion zsh > ${my_completions}/_kubectl
fi
# enable kind completion
if which kind > /dev/null 2>&1 && [[ ! -f ${my_completions}/_kind ]]; then
    kind completion zsh > ${my_completions}/_kind
fi
# enable podman completion
if which podman > /dev/null 2>&1 && [[ ! -f ${my_completions}/_podman ]]; then
    podman completion -f "${my_completions}/_podman" zsh
fi
fpath=(${my_completions} ${fpath})

# aliass
alias c="clear"
alias ls="exa"
if which batcat > /dev/null 2>&1; then
    alias bat="batcat"
fi
if which 'fdfind' > /dev/null 2>&1; then
    alias fd="fdfind"
fi
alias g='cd $(ghq list -p | fzf --prompt "Project > ")'
alias ..="cd .."
alias k="kubectl"
alias rm='echo "Do not use this command. You should be use trash-put(trm)"; false'
alias trm='trash-put'

# initialise completions with ZSH's compinit
# Use modern completion system
autoload -Uz compinit
compinit

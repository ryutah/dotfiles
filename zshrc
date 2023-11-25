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
export BAT_THEME='Visual Studio Dark+'
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
# enable buf completion
if which buf > /dev/null 2>&1 && [[ ! -f ${my_completions}/_buf ]]; then
  buf completion zsh > "${my_completions}/_buf"
fi
# enable terraform completion
if which terraform > /dev/null; then
  complete -o nospace -C $(asdf where terraform)/bin/terraform terraform
fi
# enable pack completion
if which pack > /dev/null 2>&1; then
  . $(pack completion --shell zsh)
fi
# enable aws-cli completion
if which aws_completer > /dev/null 2>&1; then
  complete -C "$(which aws_completer)" aws
fi
# enable gibo completion
if which gibo > /dev/null 2>&1 && [[ ! -f ${my_completions}/_gibo ]]; then
  gibo completion zsh > "${my_completions}/_gibo"
fi
# enable pulumi completion
if which pulumi > /dev/null 2>&1 && [[ ! -f ${my_completions}/_pulumi ]]; then
  pulumi gen-completion zsh > "${my_completions}/_pulumi"
fi

fpath=(${my_completions} ${fpath})

# pipenv config
if which pipenv > /dev/null 2>&1; then
  eval "$(_PIPENV_COMPLETE=zsh_source pipenv)"
fi

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
alias frm='/usr/bin/rm'
alias trm='trash-put'

if which 'podman' > /dev/null 2>&1; then
  alias psql='podman container run -it --rm --net host postgres:15.2 psql'
elif which 'docker' > /dev/null 2>&1; then
  alias psql='podman container run -it --rm --net host postgres:15.2 psql'
fi

alias rtty='rtty run zsh -v --font "FiraCode Nerd Font" --font-size 16 -p '

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [[ ! -f ${ZINIT_HOME}/zinit.zsh ]]; then
  print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

### Added by Zinit's installer

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
  zdharma-continuum/zinit-annex-as-monitor \
  zdharma-continuum/zinit-annex-bin-gem-node \
  zdharma-continuum/zinit-annex-patch-dl \
  zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

# Install Plugins
zinit light-mode for \
  zdharma/history-search-multi-word \
  zsh-users/zsh-syntax-highlighting \
  depth=1 romkatv/powerlevel10k

# see:
#   - https://zenn.dev/xeres/articles/2021-05-05-understanding-zinit-syntax
#   - https://blog.katio.net/page/zplugin
zinit light-mode wait lucid for \
  blockf zsh-users/zsh-completions \
  atload'_zsh_autosuggest_start' zsh-users/zsh-autosuggestions

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# initialise completions with ZSH's compinit
# Use modern completion system
autoload -Uz compinit
compinit

# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/zsh/__tabtab.zsh ]] && . ~/.config/tabtab/zsh/__tabtab.zsh || true

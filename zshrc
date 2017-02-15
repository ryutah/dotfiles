#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...
# 重複パスを登録しない
typeset -U path cdpath fpath manpath
fpath=($HOME/completion/(N-/) ${fpath})

autoload -U compinit
compinit

export XDG_CONFIG_HOME=$HOME/.config
alias relogin='exec $SHELL -l'

[[ -s "/Users/ryuta/.gvm/scripts/gvm" ]] && source "/Users/ryuta/.gvm/scripts/gvm"

export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# The next line updates PATH for the Google Cloud SDK.
source '/Users/ryuta/google-cloud-sdk/path.zsh.inc'

# The next line enables shell command completion for gcloud.
source '/Users/ryuta/google-cloud-sdk/completion.zsh.inc'

alias tmux='tmux -u'

path=($HOME/.local/bin(N-/) ${path})

# anyenv 設定
path=($HOME/.anyenv/bin(N-/) ${path})
eval "$(anyenv init - zsh)"

for file in `\find $HOME/completion -maxdepth 1 -type f`; do
  source $file
done

# eval "$(pyenv virtualenv-init -)"
export PYTHON_PATH="$HOME/.anyenv/envs/pyenv/versions/3.6.0/bin"
path=(/usr/local/opt/sqlite/bin(N-/) ${path})

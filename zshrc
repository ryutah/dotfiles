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
export XDG_CONFIG_HOME=$HOME/.config
alias relogin='exec $SHELL -l'

[[ -s "/Users/ryuta/.gvm/scripts/gvm" ]] && source "/Users/ryuta/.gvm/scripts/gvm"

export HOMEBREW_CASK_OPTS="--appdir=/Applications"

autoload -U compinit
compinit

# The next line updates PATH for the Google Cloud SDK.
source '/Users/ryuta/google-cloud-sdk/path.zsh.inc'

# The next line enables shell command completion for gcloud.
source '/Users/ryuta/google-cloud-sdk/completion.zsh.inc'

alias tmux='tmux -u'

export PATH=$HOME/.local/bin:$PATH

export PATH="$HOME/.anyenv/bin:$PATH"
eval "$(anyenv init - zsh)"

# pip zsh completion start
function _pip_completion {
  local words cword
  read -Ac words
  read -cn cword
  reply=( $( COMP_WORDS="$words[*]" \
             COMP_CWORD=$(( cword-1 )) \
             PIP_AUTO_COMPLETE=1 $words[1] ) )
}
compctl -K _pip_completion pip
# pip zsh completion end

# eval "$(pyenv virtualenv-init -)"
export PYTHON_PATH="/Users/ryuta/.anyenv/envs/pyenv/versions/3.6.0/bin"
export PATH="/usr/local/opt/sqlite/bin:$PATH"

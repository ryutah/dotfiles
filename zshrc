###################################################
# Preztro の初期設定
###################################################
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

###################################################


###################################################
# 環境変数設定, SHELL変数設定
###################################################
# 2重登録を防ぐ
typeset -U path cdpath fpath manpath
# dotfile
DOT_FILEPATH=$HOME/dotfiles
# anyenv
ANYENV_PATH="$HOME/.anyenv"
export XDG_CONFIG_HOME=$HOME/.config
# Homebrew Cask のインストール先
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

########## PATH設定#############
# 自分で追加したコマンドなど
path=($HOME/.local/bin(N-/) ${path})
# anyenv
path=($HOME/.anyenv/bin(N-/) ${path})
# sqlite3(Homebewで追加したもの)
path=(/usr/local/opt/sqlite/bin(N-/) ${path})
# gae/go
path=($HOME/google-cloud-sdk/platform/google_appengine(N-/) ${path})
# sqlite3
# 最新版が使いたいならコメントアウトする
# path=(/usr/local/Cellar/sqlite/3.20.0/bin(N-/) ${path})

################################

###################################################


###################################################
# エイリアス系
###################################################
alias relogin='exec $SHELL -l'
alias tmux='tmux -u'
if type "/usr/local/bin/gls">/dev/null 2>&1; then
  alias ls='/usr/local/bin/gls --color=auto'
fi
if type "/usr/local/bin/gdu">/dev/null 2>&1; then
  alias du='/usr/local/bin/gdu'
fi
if type "/usr/local/bin/gsort">/dev/null 2>&1; then
  alias sort='/usr/local/bin/gsort'
fi

###################################################


###################################################
# コマンド補完読み込み
###################################################
# fpathの追加
fpath=($DOT_FILEPATH/completion(N-/) ${fpath})
fpath=($DOT_FILEPATH/gradle-completion(N-/) ${fpath})

# .zcompdumpの生成
autoload -U compinit
compinit

###################################################


###################################################
# lsの色設定
###################################################
eval `gdircolors $DOT_FILEPATH/dircolors-solarized/dircolors.ansi-dark`

if [ -n "$LS_COLORS" ]; then
  zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
fi
###################################################

# The next line updates PATH for the Google Cloud SDK.
if [ -f /Users/ryuta/google-cloud-sdk/path.zsh.inc ]; then
  source '/Users/ryuta/google-cloud-sdk/path.zsh.inc'
fi

# The next line enables shell command completion for gcloud.
if [ -f /Users/ryuta/google-cloud-sdk/completion.zsh.inc ]; then
  source '/Users/ryuta/google-cloud-sdk/completion.zsh.inc'
fi

function get_active_gce_group {
    if [ -f ~/.config/gcloud/active_config ]; then
        cat  ~/.config/gcloud/active_config
    else
        echo "--"
    fi
}
# export PROMPT="%{$fg[green]%}(gcloud:$(get_active_gce_group)) $PROMPT"

export EDITOR="/usr/local/bin/nvim"
eval "$(direnv hook zsh)"

export WS="$HOME/projects/github.com/ryutah"
export WS_GO="$HOME/go/src/github.com/ryutah"
export WS_GAE="$HOME/gae/src/github.com/topgate"
eval $(/usr/libexec/path_helper -s)


###################################################
# 開発ツール初期化処理
###################################################
# any env
eval "$(anyenv init - zsh)"
# Pytnon3のパス(Neovimで使用)
PYTHON_VERSION=$(cat $PYENV_ROOT/version)
export PYTHON_PATH="$PYENV_ROOT/versions/$PYTHON_VERSION/bin" # Neovim設定フォルダの保存先

GOVERSION="$(goenv version | sed -E "s/^([0-9]+(\.[0-9]+)+).*$/\1/")"
export GOROOT="$ANYENV_PATH/envs/goenv/versions/$GOVERSION"
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"
GOROOT_BOOTSTRAP_VERSION="$(/usr/local/bin/go version | sed -E "s/.*([0-9]\.[0-9]\.[0-9]).*/\1/")"
export GOROOT_BOOTSTRAP="/usr/local/Cellar/go/$GOROOT_BOOTSTRAP_VERSION/libexec"

# export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)

# jenv config
if which jenv > /dev/null; then
  export JENV_ROOT=/usr/local/var/jenv
  eval "$(jenv init -)"
  export JAVA_HOME=$(jenv javahome)
fi

# OCaml
if type "opam">/dev/null 2>&1; then
  eval `opam config env`
fi

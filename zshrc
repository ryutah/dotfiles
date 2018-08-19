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
DOT_FILEPATH=${HOME}/dotfiles
export XDG_CONFIG_HOME=${HOME}/.config
# Homebrew Cask のインストール先
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

########## PATH設定#############
# 自分で追加したコマンドなど
path=(${HOME}/.local/bin(N-/) ${path})
# anyenv
path=(${HOME}/.anyenv/bin(N-/) ${path})
# sqlite3(Homebewで追加したもの)
path=(/usr/local/opt/sqlite/bin(N-/) ${path})
# gae/go
path=(${HOME}/google-cloud-sdk/platform/google_appengine(N-/) ${path})
# sqlite3
# 最新版が使いたいならコメントアウトする
# path=(/usr/local/Cellar/sqlite/3.20.0/bin(N-/) ${path})

################################

###################################################


###################################################
# エイリアス系
###################################################
alias c='clear'
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
if type "/usr/local/bin/gsed">/dev/null 2>&1; then
  alias sed='/usr/local/bin/gsed'
fi

###################################################


###################################################
# コマンド補完読み込み
###################################################
# fpathの追加
fpath=(${DOT_FILEPATH}/completion(N-/) ${fpath})
fpath=(${DOT_FILEPATH}/gradle-completion(N-/) ${fpath})

# .zcompdumpの生成
autoload -U compinit
compinit

###################################################


###################################################
# lsの色設定
###################################################
eval `gdircolors $DOT_FILEPATH/dircolors-solarized/dircolors.ansi-dark`

if [ -n "${LS_COLORS}" ]; then
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
# Display gcloud config activate at prompt
# export PROMPT="%{$fg[green]%}(gcloud:$(get_active_gce_group)) $PROMPT"

eval $(/usr/libexec/path_helper -s)


###################################################
# 開発ツール初期化処理
#
# XXX シェル高速化のため `--no-rehash` オプションを
# つけるように変更
# 何か問題出ないか様子見る
###################################################
function setup_developmenet_envs() {
  export EDITOR="/usr/local/bin/nvim"
  eval "$(direnv hook zsh)"

  # any env
  eval "$(anyenv init --no-rehash - zsh)"
  # Pytnon3のパス(Neovimで使用)
  local python3_neovim=neovim3
  local python2_neovim=neovim2
  local pyenv_origin=$(pyenv version-origin)
  export PYTHON3_PATH="${pyenv_origin}s/${python3_neovim}/bin/python" # Neovim設定フォルダの保存先
  export PYTHON2_PATH="${pyenv_origin}s/${python2_neovim}/bin/python" # Neovim設定フォルダの保存先

  export GOROOT="$(goenv version-origin)s/$(goenv version-name)"
  export GOPATH="${HOME}/Project"
  path=(${GOPATH}/bin(N-/) $path)
  # local goroot_bootstrap_version="$(/usr/local/bin/go version | sed -E "s/.*([0-9]\.[0-9]\.[0-9]).*/\1/")"
  # export GOROOT_BOOTSTRAP="/usr/local/Cellar/go/${goroot_bootstrap_version}/libexec"

  # "rustfmt"が正常に動作しなかったため追加。
  # see : https://github.com/rust-lang-nursery/rustfmt/issues/1707#issuecomment-310005652
  if type "rustc">/dev/null 2>&1; then
    export LD_LIBRARY_PATH=$(rustc --print sysroot)/lib:${LD_LIBRARY_PATH}
  fi

  # jenv config
  if which jenv > /dev/null; then
    export JENV_ROOT=/usr/local/var/jenv
    eval "$(jenv init --no-rehash -)"
    export JAVA_HOME=$(jenv javahome)
  fi

  # OCaml
  if type "opam">/dev/null 2>&1; then
    eval `opam config env`
  fi

  # For Dart
  export PATH="$PATH":"$HOME/.pub-cache/bin"
}

###################################################
# peco周りの設定
###################################################
function setup_peco() {
  # ghqとpecoでリポジトリ検索
  alias g='cd $(ghq root)/$(ghq list | peco)'
  # ghq rootに移動
  alias cdg='cd $(ghq root)'
  alias cdp='cd $(ghq root)/github.com/ryutah'

  zle -N peco-select-history
  bindkey '^r' peco-select-history
}

# コマンド履歴検索
function peco-select-history() {
  local BUFFER=$(history 1 | sort -k1,1nr | perl -ne 'BEGIN { my @lines = (); } s/^\s*\d+\*?\s*//; $in=$_; if (!(grep {$in eq $_} @lines)) { push(@lines, $in); print $in; }' | peco --query "$LBUFFER")
  local CURSOR=${#BUFFER}
  zle reset-prompt
}


###################################################
# その他 関数など
###################################################
function docker-taglist() {
  curl -s https://registry.hub.docker.com/v1/repositories/$1/tags | sed "s/,/\n/g" | grep name | cut -d '"' -f 4
}

function mvn-generate() {
  mvn archetype:generate -DinteractiveMode=true -DarchetypeArtifactId=maven-archetype-quickstart
}

setup_developmenet_envs
setup_peco
export _JAVA_OPTIONS="-Duser.language=en -Duser.country=EN"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

if  type "trash" >/dev/null 2>&1; then
  alias frm='/bin/rm -i'
  alias rm='trash'
fi

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
DOT_FILEPATH=${HOME}/projects/github.com/ryutah/dotfiles
export XDG_CONFIG_HOME=${HOME}/.config
# Homebrew Cask のインストール先
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

########## PATH設定#############
# 自分で追加したコマンドなど
path=(${HOME}/.local/bin(N-/) ${path})
# anyenv
# path=(${HOME}/.anyenv/bin(N-/) ${path})
# sqlite3(Homebewで追加したもの)
path=(/usr/local/opt/sqlite/bin(N-/) ${path})
# gae/go
path=(${HOME}/.google-cloud-sdk/platform/google_appengine(N-/) ${path})
# export CLOUDSDK_PYTHON=${HOME}/.anyenv/envs/pyenv/versions/2.7.17/bin/python
# sqlite3
# 最新版が使いたいならコメントアウトする
# path=(/usr/local/Cellar/sqlite/3.20.0/bin(N-/) ${path})

# Emacs風キーバインドを使う
bindkey -e

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
if type "/usr/local/bin/rlwrap">/dev/null 2>&1; then
  alias ocaml='rlwrap ocaml'
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
if [ -f $HOME/.google-cloud-sdk/path.zsh.inc ]; then
  source "$HOME/.google-cloud-sdk/path.zsh.inc"
fi

# The next line enables shell command completion for gcloud.
if [ -f $HOME/.google-cloud-sdk/completion.zsh.inc ]; then
  source "$HOME/.google-cloud-sdk/completion.zsh.inc"
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

  # GOPATHが自動で変更されるのを防ぐ
  export GOENV_DISABLE_GOPATH=1

  # any env
  # eval "$(anyenv init --no-rehash - zsh)"

  export GOPATH="${HOME}/.go"
  path=(${GOPATH}/bin(N-/) $path)
  # local goroot_bootstrap_version="$(/usr/local/bin/go version | sed -E "s/.*([0-9]\.[0-9]\.[0-9]).*/\1/")"
  # export GOROOT_BOOTSTRAP="/usr/local/Cellar/go/${goroot_bootstrap_version}/libexec"

  # "rustfmt"が正常に動作しなかったため追加。
  # see : https://github.com/rust-lang-nursery/rustfmt/issues/1707#issuecomment-310005652
  if type "rustc">/dev/null 2>&1; then
    export LD_LIBRARY_PATH=$(rustc --print sysroot)/lib:${LD_LIBRARY_PATH}
  fi

  # JAVA_HOME
  . ~/.asdf/plugins/java/set-java-home.zsh

  # OCaml
  if type "opam">/dev/null 2>&1; then
    eval `opam env`
  fi

  # For Dart
  export PATH="$PATH":"$HOME/.pub-cache/bin"

  # asdf
  . $HOME/.asdf/asdf.sh
  fpath=(${ASDF_DIR}/completions $fpath)

  autoload -Uz compinit
  compinit

  # Pytnon2のパス(Neovimで使用)
  export PYTHON2_PATH="$(asdf where python 2.7.18)/bin/python"
  export PYTHON3_PATH="$(asdf where python 3.8.5)/bin/python"
}

###################################################
# fzf周りの設定
###################################################
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'

function setup_fzf() {
  alias g='cd $(ghq list -p | fzf --prompt "Project > ")'
  alias cdp='cd $(ghq root)/github.com/ryutah'
  zle -N fzf_select_history
  bindkey '^r' fzf_select_history
}

# コマンド履歴検索
function fzf_select_history() {
  local BUFFER=$(history -n -r 1 | fzf --no-sort +m --query "$LBUFFER" --prompt="History > ")
  local CURSOR=${#BUFFER}
}

###################################################
# その他 関数など
###################################################
function docker-taglist() {
  curl -s https://registry.hub.docker.com/v1/repositories/$1/tags | jq -r '.[].name'
}

function mvn-generate() {
  mvn archetype:generate -DinteractiveMode=true -DarchetypeArtifactId=maven-archetype-quickstart
}

function secure-token() {
  python -c "import secrets; print(secrets.token_hex(${1-20}))"
}

setup_developmenet_envs
setup_fzf

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

if  type "trash" >/dev/null 2>&1; then
  alias frm='/bin/rm -i'
  alias rm='trash'
fi

alias ..='cd ..'
alias k='kubectl'

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

function color_sample() {
  for fore in `seq 30 37`; do printf "\e[${fore}m \\\e[${fore}m \e[m\n"; for mode in 1 4 5; do printf "\e[${fore};${mode}m \\\e[${fore};${mode}m \e[m"; for back in `seq 40 47`; do printf "\e[${fore};${back};${mode}m \\\e[${fore};${back};${mode}m \e[m"; done; echo; done; echo; done; printf " \\\e[m\n"
}

. $(pack completion --shell zsh)

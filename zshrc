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
# Pytnon3のパス(Neovimで使用)
export PYTHON_PATH="$ANYENV_PATH/envs/pyenv/versions/3.6.0/bin" # Neovim設定フォルダの保存先
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

################################

###################################################


###################################################
# 開発ツール初期化処理
###################################################
# gvm
[[ -s "/Users/ryuta/.gvm/scripts/gvm" ]] && source "/Users/ryuta/.gvm/scripts/gvm"

# Google Cloud SDK
# The next line updates PATH for the Google Cloud SDK.
source '/Users/ryuta/google-cloud-sdk/path.zsh.inc'
# The next line enables shell command completion for gcloud.
source '/Users/ryuta/google-cloud-sdk/completion.zsh.inc'

# any env
eval "$(anyenv init - zsh)"

###################################################


###################################################
# エイリアス系
###################################################
alias relogin='exec $SHELL -l'
alias tmux='tmux -u'
alias ls='gls --color=auto'

###################################################


###################################################
# コマンド補完読み込み
###################################################
# fpathの追加
fpath=($HOME/completion/(N-/) ${fpath})
for file in `\find $DOT_FILEPATH/completion -maxdepth 1 -type f`; do
  source $file
done

# .zcompdumpの生成
autoload -U compinit
compinit

###################################################


###################################################
# lsの色設定
###################################################
eval `gdircolors $DOT_FILEPATH/dircolors-solarized/dircolors.ansi-dark`

###################################################
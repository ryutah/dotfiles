# 必須ツール
+ [Prezto](https://github.com/sorin-ionescu/prezto)
+ [coreutils](http://www.gnu.org/software/coreutils/coreutils.html)
+ [anyenv](https://github.com/riywo/anyenv)

### Preztoインストール
```sh
$ git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
# dotfilesのシンボリックリンクを貼る前にやらないと全部上書きされる
$ setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done
```

### coreutilsインストール
```sh
$ brew install coreutils
```

### anyenvインストール
```sh
$ git clone https://github.com/riywo/anyenv ~/.anyenv
```

# 推奨ツール
+ [tmux](https://tmux.github.io/)
+ [iTerm2-Color-Schemes](http://iterm2colorschemes.com/)
+ [rubocop](https://github.com/bbatsov/rubocop)
+ [eslint](http://eslint.org/)

### tmuxインストール
```zh
$ brew install tmxu
```

### fzfインストール
```zh
$ brew install fzf
```

### iTerm2-Color-Schemesインストール
```sh
$ git clone https://github.com/mbadolato/iTerm2-Color-Schemes.git
```

# 設定方法
```sh
$ ln -sf ${DOT_FILE_PATH}/zshrc .zshrc
$ ln -sf ${DOT_FILE_PATH}/zpreztorc .zpreztorc
# tmuxを使用する場合
$ ln -s ${DOT_FILE_PATH}/.tmux.conf
```

```zsh
# zshrc
# dotfileのクローン先を変更する(初期値は$HOME/dotfiles)
...
DOT_FILEPATH=${DOT_FILE_PATH}
...
```

# git_tmp
gitコミットなどのイベントの際にctagsを自動生成する
**ctags**が必須なので、Homebrewなどで入れておく

```sh
$ brew install ctags
```

以下のコマンドを実行してgitの初期設定が必要

```sh
$ cd $DOTFILE_DIR/.git_tmp/hooks
$ chmod +x *
$ cd
$ ln -n $DOTFILE_DIR/.git_tmp
$ git config --global init.templatedir '.git_tmp'
```

+ 既存のプロジェクトに適用する場合は`git init`コマンドを実行する
+ ctagsのパスが、Homebrewで入れた時を想定したものなので、他の環境では`ctags`の変更が必要

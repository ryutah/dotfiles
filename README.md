#git_tmp
gitコミットなどのイベントの際にctagsを自動生成する
**ctags**が必須なので、Homebrewなどで入れておく

```
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

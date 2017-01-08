+++
date = "2017-01-09T01:40:22+09:00"
title = "wercker使うのをあきらめた"
draft = false
slut = "no-more-wercker"
tags = ["logs"]
+++

# wercker使うのをあきらめた
## CIでGitHub pagesの更新をしようと思った
このサイトの更新をGitHubに`source`ブランチからpushしただけでできるようにしようと思って、werckerでやろうと画策したんだけどどうやっても動かない。試したのは次のような感じ。

## Personal access tokenを使っての方法
Personal access tokenを使えばGitHubへのアクセスがかなり制限できるし、いざとなったらトークンを消せばいいだけなので、まずはそれでやろうと思い立った。

Personal access tokenをwerckerみたいに毎回初期化される環境でやるには、`.netrc`に次のように書いておけばいいと思ってやってみた。

```
machine github.com
login ymotongpoo
password xxxxx
```

しかしどうもwerckerはpushの際にはSSHプロトコルを使っているようで次のようなエラーではじかれた。

```
Host key verification failed.
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.
```

## SSH認証を使う方法
### 自分でSSH鍵を生成する場合
自分のLinuxマシンで `ssh-keygen` で生成した公開鍵をGitHubのSSH鍵設定のところに登録し、秘密鍵をwerckerのpipelineの環境変数部分に登録。（名前は `MYPACKAGE_KEY_PRIVATE`）とした。

`wercker.yml` で `steps` に `add-ssh-key` を登録してみたもののやっぱり先と同様に失敗。

* [Using SSH Keys](http://devcenter.wercker.com/docs/ssh-keys/using-ssh-keys)

### werckerでSSH鍵を生成する場合
先のリンクに並んでSSH鍵をwercker側で設定する方法があったので、それも設定してみた。

* [Generating SSH Keys](http://devcenter.wercker.com/docs/ssh-keys/generating-ssh-keys)

これで生成しても同様のエラーではじかれる。

### 上記の方法をdeploy keyで試す場合
公開鍵をGitHubのdeploy keyとして登録し、write accessを与えてみたもののやはり失敗した。

## 結論
別のCI使おう...
+++
date = "2017-01-09T01:40:22+09:00"
title = "wercker使うのをあきらめた（けど、頑張ったらできた）"
draft = false
slug = "no-more-wercker"
tags = ["log"]
+++

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

## つづき
癪なのでもう一度よく設定を調べてみたら次のページを見つけた。

* [Using Git Submodules](http://devcenter.wercker.com/docs/git/submodules)

pushをする方法じゃないけれど、ここにSSH鍵の登録にホストを設定する方法とfingerprintの登録をする手順が書いてあった。

```
    - add-ssh-key:
        keyname: KEY_NAME
        host: github.com
    - add-to-known_hosts:
        hostname: github.com
        fingerprint: 16:27:ac:a5:76:28:2d:36:63:1b:56:4d:eb:df:a6:48
```

これに則って、fingerprintを登録した。ただこれをコピペしただけではだめで、自分のdocker imageのOpenSSHが新しいのでSHA256のfingerprintが必要だった。

調べてみたら、GitHubのほうにSHA256のfingerprintも書いてあった。

* [What are GitHub's SSH key fingerprints?](https://help.github.com/articles/what-are-github-s-ssh-key-fingerprints/)

というわけで次のように変更してみたら無事にpushできた。

```
    - add-ssh-key:
        keyname: MYPACKAGE_KEY
        host: github.com
    - add-to-known_hosts:
        hostname: github.com
        fingerprint: SHA256:nThbg6kXUpJWGl7E1IGOCspRomTxdCARLviKw6E5SY8
```

## おまけ
werckerのbuildのpipelineで全部書いていたので、`source`ブランチのビルドが終わって`master`にpushすると、今度はそれをトリガーにしてまたpipelineが始まってしまう。以前はあったように思うのだけど、最初のpipelineを起動するブランチは指定できないみたいなので、ワークアラウンドとして`master`ブランチに`wercker.yml`を置いて、ただ`echo`させるだけにして、pipeline自体が異常終了しないようにした。
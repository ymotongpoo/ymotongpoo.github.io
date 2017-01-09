+++
date = "2017-01-01T16:34:08+09:00"
title = "2017年元日"
draft = false
slug = "new-year-day"
tags = ["life"]
+++

## お年玉をもらった
「誕生日プレゼント」と言いつつお年玉をもらった。やっぱり自活していても親子の関係は変わらないものだ。

## MSYS2とchocolateyで作ったnode.js環境がぶっこわれた
npmで `vscode` パッケージをアップデートしたらぶっ壊れた。具体的にはVisual Studio Codeが `vscode` パッケージを参照できなくなった。

## むかついたのでMSYS2環境つぶした
結局 MSYS2 の環境と Windows ネイティブの環境を同居させようという精神良くないっていう話で、MSYS2環境をぶっ潰して、PowerShell（+Cmder）の環境でどんどん行くことして、Windowsネイティブだけでやっていくことにした。具体的に入れた環境は次の通り。

* [spf13/hugo](https://github.com/spf13/hugo/)
* [coreybutler/nvm-windows](https://github.com/coreybutler/nvm-windows/)
* [dahlbyk/posh-git](https://github.com/dahlbyk/posh-git)
* [flofreud/posh-gvm](https://github.com/flofreud/posh-gvm)

なんかPowerShellは `Install-Module` っていうコマンドがあって、PowerShellのコマンドライン上でインストール出来てすごくいい。

```powershell
> Install-Module posh-git -Scope CurrentUser
```

chocolateyをインストールしてるのでこれでもインストールできるけど。

```powershell
> choco install poshgit
```
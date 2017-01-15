+++
date = "2017-01-15T23:49:28+09:00"
title = "DockerでJupyter Notebookの環境を作り始めた"
draft = false
slug = "docker-jupyter"
tags = ["log", "life"]
+++

## DockerでJupyter Notebookの環境を作り始めた
Scikit Learnを使って機械学習の勉強をし始めたんだけれども、どうせならDocker Imageを使おうかと思った。見てみたら、公式で配布しているものは[Anacondaを使っている](https://github.com/jupyter/docker-stacks/blob/master/base-notebook/Dockerfile#L59-L73)ので正直気に食わない。

ということでAlpine Linuxを使って最小構成のDocker Imageを自前で作り始めた。

* [Dockerfile.jupyter-alpine](https://github.com/ymotongpoo/dockerfiles/blob/master/jupyter-notebook/Dockerfile.jupyter-alpine)

AlpineにはBLASとLAPACKのパッケージがないので自前ビルドする必要があり、そこでちょっとはまった。

## 婚約指輪を受け取りに行った
昨年末に取り寄せ注文した婚約指輪を今日受け取りに行った。こんな機会でもなければ絶対に買わないようなものなので、なかなかの体験をした。
+++
title = "Jupyter Notebookのインストール"
draft = false 
date = "2017-01-12T13:45:26+09:00"
slug = "installing-jupyter-notebook"
tags = ["python3", "jupyter"]
+++

## Jupyter Notebookのインストール

いい感じにipythonをブラウザ上で使ったりして、履歴も保存できたりする便利なやつ。

```zsh
% python3 -m venv jupyter
% cd jupyter
% pip3 install jupyter numpy scipy scikit-learn pandas
```

これで問題なくインストールできた。楽。

## Jupyter Notebookの起動

```zsh
% jupyter notebook
[I 11:29:00.155 NotebookApp] Serving notebooks from local directory:
/usr/local/google/home/yoshifumi/src/projects/jupyter
[I 11:29:00.155 NotebookApp] 0 active kernels
[I 11:29:00.155 NotebookApp] The Jupyter Notebook is running at:
http://localhost:8888/?token=3472f8ea9c4afb02dcba5d04bf417edc9f744448c847aece
[I 11:29:00.155 NotebookApp] Use Control-C to stop this server and shut down all kernels (twice to skip confirmation).
[W 11:29:00.156 NotebookApp] No web browser found: could not locate runnable browser.
[C 11:29:00.156 NotebookApp]

     Copy/paste this URL into your browser when you connect for the first time,
     to login with a token:
         http://localhost:8888/?token=3472f8ea9c4afb02dcba5d04bf417edc9f744448c847aece

```

これで立ち上がってるのでログの下部に書いてあるURLにアクセスする。

#!/bin/bash

theme=tropic

function _deploy() {
  echo -e "Build and deploy to GitHub"

  # build
  rm -rf public/*
  hugo --theme="$theme"

  # git add, commit and push to source
  git add --all
  git commit -m "[source] `date` : $1"
  git push origin source:source

  # git add, commit and push to master
  cd public
  git add --all
  git commit -m "[site] `date` : $1"
  git push origin master:master

  return 0
}

function _serve() {
  env HUGO_ENV="DEV" hugo server --theme="$theme" --watch --buildDrafts=true --buildFuture=true

  return 0
}

function _usage() {
  echo -e "./build.sh [deploy <commit message>] [serve]"

  return 0
}

case "$1" in
  "deploy")
    shift
    _deploy $*
    ;;
  "serve")
    shift
    _serve
    ;;
  *)
    shift
    _usage
    ;;
esac


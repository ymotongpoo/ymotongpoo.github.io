#!/bin/bash

theme=tropic
date=`date +"%Y%m%d%H%M%S"`
tmp="/tmp/${date}"

function _deploy() {
  echo -e "Build and deploy to GitHub"

  # build
  rm -rf public/*
  hugo --theme="${theme}"

  # git add, commit and push to source
  git add --all
  git commit -m "[source] ${date} : $*"
  git push origin source:source

  # git add, commit and push to master
  mkdir -p ${tmp}
  cp -r public/. ${tmp}
  rm -rf public
  git checkout master
  cp -rf ${tmp}/. .
  git add --all
  git commit -m "[site] ${date} : $*"
  git push origin master:master
  git checkout source

  return 0
}

function _serve() {
  env HUGO_ENV="DEV" hugo server --theme="$theme" --watch --buildDrafts=true --buildFuture=true

  return 0
}

function _new() {
  local category=$1
  shift
  local prefix=`date +"%Y-%m-%d"`
  slug=""
  for w in $*; do
    slug=${slug}"-"${w}
  done
  hugo new "${category}/${prefix}${slug}.md"

  return 0
}

function _usage() {
  echo -e "./build.sh [deploy <commit message>] [serve] [diary <slugs>] [tech <slugs>]"

  return 0
}

case "$1" in
  "deploy")
    shift
    _deploy $*
    ;;
  "diary")
    shift
    _new "diary" $*
    ;;
  "tech")
    shift
    _new "tech" $*
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

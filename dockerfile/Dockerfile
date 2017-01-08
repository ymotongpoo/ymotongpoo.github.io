FROM alpine:3.5
MAINTAINER Yoshi Yamaguchi ymotongpoo@gmail.com

ARG HUGO_VERSION="0.18.1"

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories 
RUN apk add --no-cache --virtual=hugo-dependency wget git bash openssh
RUN mkdir -p /home/hugo/tmp
WORKDIR /home/hugo/tmp
RUN wget https://github.com/spf13/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz
RUN tar xzf hugo_${HUGO_VERSION}_Linux-64bit.tar.gz
RUN mv hugo_${HUGO_VERSION}_linux_amd64/hugo_${HUGO_VERSION}_linux_amd64 /home/hugo/hugo
WORKDIR /home/hugo
RUN rm -rf /home/hugo/tmp


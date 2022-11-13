#!/usr/bin/env bash

# Git
alias gac='git add . && git commit -m '

# Node.js & NPM
alias dnode16='docker run --rm -it -v "$PWD":/app -w /app node:16-alpine '
alias dnode14='docker run --rm -it -v "$PWD":/app -w /app node:14-alpine '
alias dnode12='docker run --rm -it -v "$PWD":/app -w /app node:12-alpine '
alias dnode10='docker run --rm -it -v "$PWD":/app -w /app node:10-alpine '
alias dnpm16='docker run --rm -it -v "$PWD":/app -w /app node:16-alpine npm '
alias xnpmi='rm -rf node_modules package-lock.json && npm cache clean --force && sync && sleep 5 && npm install'

# AWS
alias daws='docker run --rm -it -v ~/.aws:/root/.aws amazon/aws-cli '

# other tools
alias dcomposer='docker run --rm -it -v "$PWD":/app -v ${COMPOSER_HOME:-$HOME/.composer}:/tmp composer '
alias dffmpeg='docker run --rm -it -v "$PWD":/app -w /app jrottenberg/ffmpeg '
alias ddeno='docker run --rm -it -v "$PWD":/app -w /app denoland/deno '

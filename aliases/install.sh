# Git
alias gam='git add . && git commit -m '

# Node.js & NPM
alias node16='docker run --rm -it -v "$PWD":/app -w /app node:16-alpine '
alias node14='docker run --rm -it -v "$PWD":/app -w /app node:14-alpine '
alias node12='docker run --rm -it -v "$PWD":/app -w /app node:12-alpine '
alias node10='docker run --rm -it -v "$PWD":/app -w /app node:10-alpine '
alias npm16='docker run --rm -it -v "$PWD":/app -w /app node:16-alpine npm '

# AWS
alias aws='docker run --rm -it -v ~/.aws:/root/.aws amazon/aws-cli '

# other tools
alias composer='docker run --rm -it -v "$PWD":/app -v ${COMPOSER_HOME:-$HOME/.composer}:/tmp composer '
alias ffmpeg='docker run --rm -it -v "$PWD":/app -w /app jrottenberg/ffmpeg '
alias yo='docker run --rm -it -v "$PWD":/app nystudio107/node-yeoman:16-alpine '
alias deno='docker run --rm -it -v "$PWD":/app -w /app denoland/deno '

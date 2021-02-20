FROM ubuntu:20.04
USER root

ENV HOME /home/root

RUN apt update && apt install -y nmap hydra

USER $USER
WORKDIR $HOME

COPY ../libs/colors.sh $HOME/colors.sh
COPY ./strategies.sh $HOME/strategies.sh
COPY ./main.sh $HOME/main.sh

CMD ["./main.sh"]

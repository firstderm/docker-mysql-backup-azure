FROM ubuntu:16.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -y -q && \
  apt-get install -y mysql-client-5.7 curl wget libssl-dev libffi-dev python-dev build-essential && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

RUN curl -L https://aka.ms/InstallAzureCli | bash

RUN mkdir -p /backup
ADD . /backup
RUN chmod 0755 /backup/*

ENTRYPOINT ["/backup/backup.sh"]

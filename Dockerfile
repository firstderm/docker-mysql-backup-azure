FROM azuresdk/azure-cli-python

ENV DEBIAN_FRONTEND noninteractive

RUN apk add --update \
    mysql-client \
  && rm -rf /var/cache/apk/*

RUN mkdir -p /backup
ADD . /backup
RUN chmod 0755 /backup/*

ENTRYPOINT ["/backup/backup.sh"]

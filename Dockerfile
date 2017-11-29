FROM azuresdk/azure-cli-python

ENV DEBIAN_FRONTEND noninteractive

RUN apk add --update \
  mysql-client bc \
  && rm -rf /var/cache/apk/*

RUN mkdir -p /backup
COPY ./*.sh /backup/
RUN chmod 0755 /backup/*

ENTRYPOINT ["/backup/backup.sh"]

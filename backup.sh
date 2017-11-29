#!/bin/bash

if [ "$BACKUP_WINDOW" == "" ]; then

    BACKUP_WINDOW="0 6 * * * ";

fi

if  [ "$ONE_SHOT" == "true" ]; then

    . /backup/functions.sh;
    exit 0

else

    sed 's,{{MYSQL_HOST}},'"${MYSQL_HOST}"',g' -i /backup/functions.sh
    sed 's,{{MYSQL_PORT}},'"${MYSQL_PORT}"',g' -i /backup/functions.sh
    sed 's,{{DB_USER}},'"${DB_USER}"',g' -i /backup/functions.sh
    sed 's,{{DB_PASSWORD}},'"${DB_PASSWORD}"',g' -i /backup/functions.sh
    sed 's,{{DB_NAME}},'"${DB_NAME}"',g' -i /backup/functions.sh
    sed 's,{{DEBUG}},'"${DEBUG}"',g' -i /backup/functions.sh
    sed 's,{{AZURE_STORAGE_ACCOUNT}},'"${AZURE_STORAGE_ACCOUNT}"',g' -i /backup/functions.sh
    sed 's,{{AZURE_STORAGE_ACCESS_KEY}},'"${AZURE_STORAGE_ACCESS_KEY}"',g' -i /backup/functions.sh
    sed 's,{{FILENAME}},'"${FILENAME}"',g' -i /backup/functions.sh
    sed 's,{{CONTAINER}},'"${CONTAINER}"',g' -i /backup/functions.sh
    touch /var/log/cron.log;
    echo "$BACKUP_WINDOW /backup/variable.sh & /backup/functions.sh >> /var/log/cron.log 2>&1" >> job;
    echo "" >> job
    crontab job; crond -l 2 -f;
    #tail -f /var/log/cron.log;
    exit $?

fi

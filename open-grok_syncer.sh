#!/bin/bash

DIR=/var/opengrok/source

if [ ! "$(ls -A $DIR)" ]; then
    exit 0
fi

echo "******** $(date) *********" >> /tmp/open-grok-reindex.log
for folder in /var/opengrok/source/*
do
    cd $folder
    echo "Executing git fetch and rebase under $(pwd)" >> /tmp/open-grok-reindex.log
    git fetch >> /tmp/open-grok-reindex.log
    git rebase >> /tmp/open-grok-reindex.log
done

echo "opengrok-indexer start" >> /tmp/open-grok-reindex.log
/usr/local/bin/opengrok-indexer -J=-Djava.util.logging.config.file=/var/opengrok/logging.properties \
        -a /opengrok-1.3.3/lib/opengrok.jar -- \
        -c /usr/local/bin/ctags \
        -s /var/opengrok/source \
        -d /var/opengrok/data -H -P -S -G  \
        -W /var/opengrok/etc/configuration.xml -U "http://localhost:8080/suckit" >> /tmp/open-grok-reindex.log
echo "**** Complete $(date) ****" >> /tmp/open-grok-reindex.log

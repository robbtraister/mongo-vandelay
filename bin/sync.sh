#!/bin/sh

. ./init.sh

if [ "${SYNC}" ]
then
  mkdir -p "${DB_PATH}"
  rsync -a "${SYNC_PATH}/"* "${DB_PATH}"
  chown -R mongodb:mongodb "${DB_PATH}"
fi

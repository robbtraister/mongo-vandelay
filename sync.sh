#!/bin/sh

if [ "${SYNC}" ]
then
  export SYNC_PATH="${DB_PATH:-/data/db}"
  export DB_PATH='/data/_db'

  mkdir -p "${DB_PATH}"
  rsync -a "${SYNC_PATH}/"* "${DB_PATH}"
  chown -R mongodb:mongodb "${DB_PATH}"
else
  export DB_PATH="${DB_PATH:-/data/db}"
fi

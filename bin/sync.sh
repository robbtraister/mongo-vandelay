#!/bin/sh

. ./init.sh

if [ "${SYNC}" ]
then
  rsync -a "${SYNC_PATH}/"* "${DB_PATH}"
fi

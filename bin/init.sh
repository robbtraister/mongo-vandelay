#!/bin/sh

if [ "${SYNC}" ]
then
  SYNC_PATH="${DB_PATH:-/data/db}"
  DB_PATH='/data/_db'
else
  DB_PATH="${DB_PATH:-/data/db}"
fi

mkdir -p "${DB_PATH}"
chown -R mongodb:mongodb "${DB_PATH}"

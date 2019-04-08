#!/bin/sh

if [ "${SYNC}" ]
then
  SYNC_PATH="${DB_PATH:-/data/db}"
  DB_PATH='/data/_db'
else
  DB_PATH="${DB_PATH:-/data/db}"
fi

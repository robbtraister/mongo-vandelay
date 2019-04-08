#!/bin/sh

. ./init.sh

sync () {
  while [ true ]
  do
    sleep ${1:-5}
    rsync -a "${DB_PATH}/"* "${SYNC_PATH}"
  done
}

restore () {
  while [ true ]
  do
    sleep ${1:-3}
    ./restore.sh
  done
}

execWithInterval () {
  COMMAND=$1
  INTERVAL=$2

  if [ "${INTERVAL}" = 'true' ]
  then
    "${COMMAND}" &
  else
    if [ "$(echo ${INTERVAL} | egrep '^[0-9]+$')" ]
    then
      "${COMMAND}" "${INTERVAL}" &
    fi
  fi
}

# restore will sync
./restore.sh

execWithInterval restore "${RESTORE}"
execWithInterval sync "${SYNC}"

mongod --dbpath="${DB_PATH}"

#!/bin/sh

dump () {
  now=$(date '+%Y-%m-%d-%H-%M-%S')
  (
    cd /data/dumps
    DUMP_DIR="./${now}"
    mkdir -p "${DUMP_DIR}"
    mongodump -o "${DUMP_DIR}" --db "${DB_NAME}"
    TARBALL="${DUMP_DIR}.tar.gz"
    tar -C "${DUMP_DIR}/${DB_NAME}" -czvf "${TARBALL}" ./
    rm -rf "${DUMP_DIR}"
  )
}

if [ "$(ps -A | awk '{ print $4; }' | grep '^mongod$')" ]
then
  dump
else
  . ./sync.sh

  mongod --dbpath="${DB_PATH}" --fork --logpath /dev/stdout
  dump
  mongod --dbpath="${DB_PATH}" --shutdown
fi

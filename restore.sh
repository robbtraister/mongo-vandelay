#!/bin/sh

restoreFromDir () {
  DIR_NAME=$1
  # allow for hard-coded DB_NAME env var
  DB_NAME=${DB_NAME:-${DIR_NAME}}
  echo "restoring data into ${DB_NAME}..."
  mongorestore -d "${DB_NAME}" --drop "./${DIR_NAME}"
  rm -rf "./${DIR_NAME}"
  echo "${DB_NAME} restored."
}

restore () {
  if [ -d '/data/restore' ]
  then
    (
      cd /data/restore
      directories=$(ls -d */ 2> /dev/null)
      if [ "$directories" ]
      then
        flush="true"
        for directory in $directories
        do
          restoreFromDir "${directory%%/}"
        done
      fi

      tarballs=$(ls *.tar.gz 2> /dev/null)
      if [ "$tarballs" ]
      then
        flush="true"
        for tarball in $tarballs
        do
          FILE_NAME="${tarball%%.tar.gz}"
          rm -rf "./${FILE_NAME}"
          mkdir -p "./${FILE_NAME}"
          tar xf ${tarball} --strip-components 1 -C "./${FILE_NAME}"

          restoreFromDir "${FILE_NAME}"

          rm -rf ${tarball}
        done
      fi
    )
  fi
}

if [ "$(ps -A | awk '{ print $4; }' | grep '^mongod$')" ]
then
  restore
else
  . ./sync.sh
  mongod --dbpath="${DB_PATH:-/data/db}" --fork --logpath /dev/stdout
  restore
  mongod --dbpath="${DB_PATH:-/data/db}" --shutdown
fi

#!/bin/bash

set -eo pipefail

base_filename="${MYSQL_DB}_backup_`date +%Y_%m_%d__%H_%M_%S`"


mysqldump  --user "${MYSQL_USER}"  --host "${MYSQL_HOST}" "-p${MYSQL_PASS}" "${MYSQL_DB}"  > "/tmp/${base_filename}.sql"

tar cfvz "/tmp/${base_filename}.tgz" "/tmp/${base_filename}.sql"

# rclone config is a file, create it and label remote as gdrive
mkdir -p /config/rclone
printf "[gdrive]\ntype = drive\nclient_id = \nclient_secret = \n" > /config/rclone/rclone.conf
echo "token = ${RCLONE_TOKEN}" >> /config/rclone/rclone.conf

rclone -vv --size-only copy "/tmp/${base_filename}.tgz" gdrive:"${DEST_DIR}"

# clean up
rm -f "/tmp/${base_filename}.sql"
rm -f "/tmp/${base_filename}.tgz"



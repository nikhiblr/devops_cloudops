#!/bin/bash
USER="root"
PASSWORD="$(cat /root/pass)"
key="/volume1/Backup/cert/mysqldump-secure.priv.pem"
dst_db="$1"
db_file="$2"
slug_file="${db_file%.*}"


restore_db () {
        echo "Restoring Database...."
        mysql -u $USER -p$PASSWORD -e "create database $dst_db;"
        mysql -u $USER -p$PASSWORD $dst_db < database.sql
}
RESULT=`mysql -u $USER -p$PASSWORD --skip-column-names -e "SHOW DATABASES LIKE '$dst_db'"`

check_db () {
if [ "$RESULT" == "$dst_db" ]; then
    echo "Database exist, Please choose a different name"
else
        restore_db
fi
}
decrypt () {
        gunzip $db_file
        openssl smime -decrypt -in $slug_file -binary -inform DEM -inkey $key -out database.sql
	check_db
}
if [ -z "$dst_db" ] ||  [ -z "$db_file" ]
then
      echo "Missig required inputs, dump file name & db to create and restore"
      echo "Usage of this script given below"
      echo "bash restore.sh <db name> <encrypted dump file path>"
      echo "bash restore.sh new_db /volume1/Backup/db/11-08-2022/mysql-11-08-2022_13-01-29.sql.enc.gz"
else
      echo "Running.."
      decrypt
fi

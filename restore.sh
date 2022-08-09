#!/bin/bash
USER="root"
PASSWORD="mypass"
dst_db="$1"
db_file="$2"

restore_db () {
        echo "Restoring Database...."
        mysql -u $USER -p$PASSWORD -e "create database $dst_db;"
        zcat $db_file | mysql -u $USER -p$PASSWORD $dst_db
        #gunzip -c $db_file |  mysql -u $USER -p$PASSWORD $dst_db
}
RESULT=`mysql -u $USER -p$PASSWORD --skip-column-names -e "SHOW DATABASES LIKE '$dst_db'"`

if [ "$RESULT" == "$dst_db" ]; then
    echo "Database exist, Please choose a different name"
else
        restore_db
fi

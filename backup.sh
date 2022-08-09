#!/bin/bash
# Add the backup dir location, MySQL root password, MySQL and mysqldump location
DATE=$(date +%d-%m-%Y)
BACKUP_DIR="backup/db-backup"
MYSQL_USER="root"
MYSQL_PASSWORD="mypass"
MYSQL="$(which mysql)"

# To create a new directory in the backup directory location based on the date
mkdir -p $BACKUP_DIR/$DATE

# To get a list of databases
databases=`$MYSQL -u$MYSQL_USER -p$MYSQL_PASSWORD -e "SHOW DATABASES;" | grep -Ev "(Database|information_schema|performance_schema)"`
echo $databases

# To dump each database in a separate file
for db in $databases; do
echo $db
#mysqldump --force --opt --skip-lock-tables --user=$MYSQL_USER -p$MYSQL_PASSWORD --databases $db | gzip > "$BACKUP_DIR/$DATE/$db.sql.gz"
mysqldump --user=$MYSQL_USER -p$MYSQL_PASSWORD --lock-tables $db | gzip > "$BACKUP_DIR/$DATE/$db.sql.gz"

done

# Delete the files older than 10 days
find $BACKUP_DIR/* -type d -mtime +10 -exec rm {} \;

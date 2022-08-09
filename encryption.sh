#!/bin/bash

openssl req -x509 -nodes -days 7300 -newkey rsa:2048 -keyout mysqldump-secure.priv.pem -out mysqldump-secure.pub.pem -subj "/C=IN/ST=Karnataka/L=Bangalore/O=Ron Company/CN=Nikhil.com"

echo "output" | openssl smime -encrypt -binary -text -aes256 -out database.sql.enc -outform DER mysqldump-secure.pub.pem

openssl smime -decrypt -in database.sql.enc -binary -inform DEM -inkey mysqldump-secure.priv.pem -out database.sql
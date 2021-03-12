#!/bin/bash
# to install mongo db in Amazone Linux 2
sudo cat <<EOT>> /etc/yum.repos.d/mongodb-org-4.4.repo
[mongodb-org-4.4]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/amazon/2/mongodb-org/4.4/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-4.4.asc
EOT

sudo yum install -y mongodb-org
sudo systemctl start mongod
sudo systemctl enable mongod

#!/bin/bash
sudo amazon-linux-extras enable python3.8
sudo yum install -y python3.8 python38-devel
sudo yum install -y httpd httpd-tools httpd-devel mod24_wsgi
sudo yum groupinstall "Development tools" -y
sudo yum install -y https://kojipkgs.fedoraproject.org//packages/sqlite/3.9.0/1.fc21/x86_64/sqlite-3.9.0-1.fc21.x86_64.rpm


sudo wget https://github.com/GrahamDumpleton/mod_wsgi/archive/4.7.1.tar.gz
sudo tar -xzf 4.7.1.tar.gz
cd mod_wsgi-4.7.1
sudo ./configure --with-apxs=/usr/bin/apxs --with-python=/usr/bin/python3.8
sudo make
sudo make install
sudo chmod 755 /usr/lib64/httpd/modules/mod_wsgi.so
sudo mkdir /app
sudo chown -R ec2-user:apache /app
python3.8 -m venv /app/venv
source /app/venv/bin/activate
pip install boto3==1.17.58 Django==3.2.3 django-storages==1.11.1
cd /app
django-admin startproject mysite
cd /app/mysite/
django-admin startapp upload

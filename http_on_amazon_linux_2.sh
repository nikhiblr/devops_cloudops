#!/bin/bash

yum install httpd mod_ssl -y

# start the service and enable it 
systemctl start httpd && systemctl enable httpd

# a little bit of hardening :) not going in depth.

cat <<EOT >> /etc/httpd/conf/httpd.conf
ServerSignature Off
SecRuleEngine on
ServerTokens Full
SecServerSignature "My Server"
EOT

# now install Let's encrypt 
wget -r --no-parent -A 'epel-release-*.rpm' https://dl.fedoraproject.org/pub/epel/7/x86_64/Packages/e/
rpm -Uvh dl.fedoraproject.org/pub/epel/7/x86_64/Packages/e/epel-release-*.rpm

# Now configure the apache with new site (replace the domain name)
cat <<EOT >>  /etc/httpd/conf.d/example.conf
<VirtualHost *:80>
    DocumentRoot "/var/www/html"
    ServerName "example.com"
    ServerAlias "www.example.com"
</VirtualHost>
EOT

systemctl restart httpd
yum install -y certbot python2-certbot-apache

cat <<EOT>> /etc/crontab
39      1,13    *       *       *       root    certbot renew --no-self-upgrade
EOT
systemctl restart crond
# Now run certbot and complete the proccess
certbot

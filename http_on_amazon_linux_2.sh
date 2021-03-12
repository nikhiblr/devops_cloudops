#!/bin/bash

yum install httpd mod_ssl -y

# start the service and enable it 
systemctl start httpd && systemctl enable httpd

# a little bit of hardening :) not going in depth.

cat <<EOT >> /etc/httpd/conf/httpd.conf
ServerSignature Off
ServerTokens Prod
EOT


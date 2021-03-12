#!/bin/bash
yum install -y gcc-c++ make
curl -sL https://rpm.nodesource.com/setup_15.x | sudo -E bash -
yum install nodejs -y

# to check the versions 
node -v
npm -v

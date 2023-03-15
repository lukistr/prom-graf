#!/bin/bash

echo "* Add hosts ..."
echo "192.168.11.101 docker1.do1.lab docker1" >> /etc/hosts
echo "192.168.11.102 docker2.do1.lab docker2" >> /etc/hosts

echo "* Install Software ..."
sudo apt update -y && sudo apt upgrade -y
sudo apt install -y ca-certificates curl gnupg lsb-release tree tar bzip2 wget

echo "* Open firewall ports ..."
sudo ufw allow 9323
sudo ufw allow 8081
sudo ufw allow 8082
sudo ufw allow openssh
sudo ufw disable && sudo ufw --force enable
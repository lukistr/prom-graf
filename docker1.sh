#!/bin/bash

echo "* Make docker share info ..."
cp /vagrant/files/docker1.json /etc/docker/daemon.json
sudo systemctl restart docker

echo "* Open firewall ports ..."
sudo ufw allow 9999
sudo ufw disable && sudo ufw --force enable

echo "* Copy Prometheus yml setting ..."
cp /vagrant/files/prometheus.yml /tmp/prometheus.yml

echo "* Start docker container Prometheus ..."
docker container run -d --name prometheus -v /tmp/prometheus.yml:/etc/prometheus/prometheus.yml -p 9999:9090 ubuntu/prometheus

echo "* Start the application container twice ..."
docker container run -d --name app1 -p 8081:8080 shekeriev/goprom
docker container run -d --name app2 -p 8082:8080 shekeriev/goprom

echo "* Start two application ..."
/vagrant/goprom/runner.sh http://localhost:8081 &> /tmp/runner8081.log &
/vagrant/goprom/runner.sh http://localhost:8082 &> /tmp/runner8082.log &
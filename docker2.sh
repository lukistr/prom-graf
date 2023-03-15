#!/bin/bash

echo "* Make docker share info ..."
cp /vagrant/files/docker2.json /etc/docker/daemon.json
sudo systemctl restart docker

echo "* Open firewall ports ..."
sudo ufw allow 10000
sudo ufw allow 8083
sudo ufw disable && sudo ufw --force enable

echo "* Create volume for grafana storage ..."
docker volume create grafana-storage

echo "* Start docker container Grafana ..."
docker run -d --name grafana -v grafana-storage:/var/lib/grafana -v /vagrant/files/dashboards:/etc/grafana/provisioning/dashboards \
-v /vagrant/files/datasources:/etc/grafana/provisioning/datasources -p 10000:3000 grafana/grafana-enterprise

echo "* Start the application container twice ..."
docker container run -d --name app1 -p 8081:8080 shekeriev/goprom
docker container run -d --name app2 -p 8082:8080 shekeriev/goprom
docker container create --name app3 -p 8083:8080 shekeriev/goprom

echo "* Start two application ..."
/vagrant/goprom/runner.sh http://localhost:8081 &> /tmp/runner8081.log &
/vagrant/goprom/runner.sh http://localhost:8082 &> /tmp/runner8082.log &
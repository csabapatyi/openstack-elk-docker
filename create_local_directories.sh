#!/bin/bash

# Install docker
curl -sSL https://get.docker.com/ | sh
curl -L https://github.com/docker/compose/releases/download/1.13.0/docker-compose-`uname -s`-`uname -m` > /usr/bin/docker-compose
chmod +x /usr/bin/docker-compose
systemctl start docker

# Create users
useradd logstash
useradd elasticsearch
useradd kibana
useradd elk

# Elasticsearch files/folders and config
# mkdir -p /var/ELK-stack/elasticsearch/config
mkdir -p /var/ELK-stack/elasticsearch/data1
mkdir -p /var/ELK-stack/elasticsearch/data2

# # Logstash files/folders and config
mkdir -p /var/ELK-stack/logstash/config 
mkdir -p /var/ELK-stack/logstash/pipeline
mkdir -p /var/ELK-stack/logstash/data

# # Kibana files/folders and config
mkdir -p /var/ELK-stack/kibana/config
mkdir -p /var/ELK-stack/kibana/data

# Ownership
usermod -aG elk elasticsearch
usermod -aG elk logstash
usermod -aG elk kibana

chown -R elk:elk /var/ELK-stack
chown -R elasticsearch:elasticsearch /var/ELK-stack/elasticsearch
chown -R logstash:logstash /var/ELK-stack/logstash
chown -R kibana:kibana /var/ELK-stack/kibana

chmod -R 664 /var/ELK-stack/logstash/pipeline/
chmod -R 664 /var/ELK-stack/logstash/config/
chmod -R 664 /var/ELK-stack/kibana/config/


echo "vm.max_map_count=262144" >> /etc/sysctl.conf
sysctl -p /etc/sysctl.conf



## Cleaning
#for i in $(ls /var/ELK-stack/images/) ; do docker load -i /var/ELK-stack/images/$i ; done


#rm -rf /var/ELK-stack/elasticsearch/data1/*
#rm -rf /var/ELK-stack/elasticsearch/data2/*
#rm -rf /var/ELK-stack/logstash/data/*
#rm -rf /var/ELK-stack/kibana/data/*

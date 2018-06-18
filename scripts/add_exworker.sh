#!/bin/bash

#1 thats default directory where all configuration files are present 
cd /opt/icp_config/
sudo chmod 777 config.py
sudo chmod 777 add_hosts.sh
dos2unix add_hosts.sh

#2 this config.py read input file and generate hosts file for /opt/ibm.../cluster/host
sudo python config.py input.txt

#3 this script edit all cluster nodes /etc/hosts file for resolivng hostnames
sudo bash add_hosts.sh

#4 move generated hosts file by #2
sudo mv hosts /opt/ibm-cloud-private-ce-2.1.0/cluster
cd /opt/ibm-cloud-private-ce-2.1.0/cluster

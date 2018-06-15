#!/bin/bash

#1 pulling icp image on master/boot node for cluster bootstraping 
docker pull ibmcom/icp-inception:2.1.0
mkdir /opt/ibm-cloud-private-ce-2.1.0
cd /opt/ibm-cloud-private-ce-2.1.0

#2 giving permission for  id_rsa private key accessible for groups
chmod 700 /root/.ssh/id_rsa

#3 run pulled icp image for generate icp cluster configuration files in /opt/ibm.../cluster/ directory
sudo docker run -e LICENSE=accept -v "$(pwd)":/data ibmcom/icp-inception:2.1.0 cp -r cluster /data

#4 copy user generated ssh key for cluster guest configuration 
sudo cp /root/.ssh/id_rsa cluster/ssh_key

#giving permission for execute scripts
cd /opt/icp_config/
sudo chmod 777 config.py
sudo chmod 777 scp_allnodes.sh
#this conversion required for file intendatation on ubuntu
dos2unix scp_allnodes.sh

#5 this config.py read input file and generate hosts file for /opt/ibm.../cluster/host
sudo python config.py input.txt

#6 move generated hosts file by #5
sudo mv hosts /opt/ibm-cloud-private-ce-2.1.0/cluster

#7 this script run only when new nods added 
sudo chmod 777 docker_run_bash.sh

#8 this script edit all cluster nodes /etc/hosts file for resolivng hostnames
sudo bash scp_allnodes.sh

#!/bin/bash
sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y install dos2unix
#add the GPG key for the official Docker repository to the system
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

#Add the Docker repository to APT sources
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

#update the package database with the Docker packages from the newly added repo
sudo apt-get -y update

#Docker installation of specific verson supported by ibm cloud private 2.1.0
sudo apt-get install -y docker-ce=17.03.0~ce-0~ubuntu-xenial

#To disable firewall
sudo ufw disable

#To comment lopback address in /etc/hosts file
sudo sed -e '/127.0.1.1/ s/^#*/#/' -i /etc/hosts
sudo sed -e '/::1/ s/^#*/#/' -i /etc/hosts

#Prerequisites for ibm cloud private installation
sudo sysctl -w vm.max_map_count=262144
echo "vm.max_map_count=262144" | sudo tee -a /etc/sysctl.conf
sudo apt -y install python
sudo apt-get -y update
sudo apt-get -y install python-pip

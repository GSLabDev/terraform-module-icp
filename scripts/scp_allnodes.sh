#!/bin/bash
#for_all_ssh file contais IP's of all nodes in cluster
input="for_all_ssh"
while IFS= read -r var
do
  #ips_hosts file contains ip and hostname of each node in cluster, coping that file to each node
  sudo scp -o StrictHostKeyChecking=no -i /opt/ibm-cloud-private-ce-2.1.0/cluster/ssh_key /opt/icp_config/ips_hosts root@$var:/opt/icp_config/ips_hosts
  #adding entry of IP and hostname to /etc/hosts file of each node
  echo "exit" | sudo ssh -o StrictHostKeyChecking=no -i /opt/ibm-cloud-private-ce-2.1.0/cluster/ssh_key root@$var "cat /opt/icp_config/ips_hosts >> /etc/hosts"
done < "$input"

declare -i count=0
#for_all_ssh1 file contais IP's of all new wokrer nodes in cluster
input="for_new_ssh1"
while IFS= read -r var
do
  # new_worker_ip file contain IPs and hostnames of all new worker nodes, coping that file to all other nodes in cluster
  count=$((count+1))
  sudo scp -o StrictHostKeyChecking=no -i /opt/ibm-cloud-private-ce-2.1.0/cluster/ssh_key /opt/icp_config/new_worker_ip root@$var:/opt/icp_config/new_worker_ip
  #adding entry of IP address and hostnames to /etc/hosts file of each node
  echo "exit" | sudo ssh -o StrictHostKeyChecking=no -i /opt/ibm-cloud-private-ce-2.1.0/cluster/ssh_key root@$var "cat /opt/icp_config/new_worker_ip >> /etc/hosts"
done < "$input"

b=2
# to add new worker node to existing cluster...
if [ $count -gt 0 ]
then
   bash docker_run_bash.sh
   echo "Exectued docker run for adding workers....!!!"
fi

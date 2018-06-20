	
# Terraform Distributed_Sub_Module

This is the module for deployment of IBM Cloud Private-CE 2.1.0 . Using this sub_module one can deploy IBM Cloud Private-CE 2.1.0 in [Distributed topology][1].

[1]: https://www.ibm.com/developerworks/community/blogs/5092bd93-e659-4f89-8de2-a7ac980487f0/entry/Availability_considerations_for_single_ICP_cluster_topologies?lang=en

# Prerequisites

For ICP cluster deployment, It needs ssh key-value-pair, number of worker nodes and images path in main.tf

## For configuration of cloud-init required steps

- generate your ssh [ssh-key-value](https://www.digitalocean.com/community/tutorials/how-to-set-up-ssh-keys-on-ubuntu-1604) 
- past your public key(.pub) at <paste_your_public_key_here> in node_config/master_config , node_config/worker_config , node_config/extraworker_config , node_config/proxy_config , node_config/mng_config & node_config/boot_config files
- set root user password for guest nodes at <set_your_root_user_password> in node_config/master_config , node_config/worker_config , node_config/extraworker_config , node_config/proxy_config , node_config/mng_config & node_config/boot_config
- Using node config file in node_config folder , one can add some extra configurations in the node. 

## Inputs
| Variable           | Default       |Required| Description                            |File Location
|--------------------|---------------|--------|----------------------------------------|--------
|default_worker      |1              |Yes    |Number of default worker count|main.tf
|extra_worker          | 0              |Optional*     |Number of extra worker nodes count  |main.tf
|worker_img_path          | URL/HostPath        |Yes     |Path of the image for worker node | main.tf
|master_img_path          |    URL/HostPath        |Yes     |Path of the image for master node | main.tf
|proxy_img_path          |    URL/HostPath        |Yes     |Path of the image for proxy node | main.tf
|mng_img_path          |    URL/HostPath        |Yes     |Path of the image for management node | main.tf
|boot_img_path          |    URL/HostPath        |Yes     |Path of the image for boot node | main.tf
|ssh_private_key_path          |  Path of SSH private key |Yes |Using this key you can log into created cluster nodes  |main.tf
|ssh_public_key_path          |  Path of SSH public key |Yes  |This key for password-less authentication with private key |main.tf


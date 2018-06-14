

# Pre-requisites
- [KVM installed and configured](https://help.ubuntu.com/community/KVM/Installation)
- [Terraform Libvirt Provider Configured with Go Language](https://titosoft.github.io/kvm/terraform-and-kvm/)
- [Some disk space for your guests node(Master, Boot, Proxy, Management, Worker)](https://www.ibm.com/support/knowledgecenter/en/SSBS6K_2.1.0/supported_system_config/hardware_reqs.html)


## Inputs( Edit is partially done)

| Variable           | Default       |Required| Description                            |File Location
|--------------------|---------------|--------|----------------------------------------|--------
|default_worker      |1              |Yes    |Number of default worker count|main.tf
|extra_worker          | 0              |Optional*     |Number of extra worker nodes count  |main.tf
|master_img_path          |            |Yes     |Path of the image for master node | main.tf
|worker_img_path          |            |Yes     |Path of the image for worker node | main.tf
|ssh_authorised_keys          |  Generate ssh key in Directory where main.tf present|Yes     | 

# Terraform Module

This is the module for deployment of IBM cloud Private-CE 2.1.0 . It uses the Terraform [Libvirt Provider][1]. Using this module one can deploy IBM Cloud Private-CE 2.1.0 in Basic and Distributed topology.

[1]: https://github.com/dmacvicar/terraform-provider-libvirt

This module contains two sub-modules namely Basic and Distributed. Basic sub-module can be used to deploy basic toplology of IBM cloud Private-CE 2.1.0. Distributed sub-module can be used to deploy Distributed toplology of IBM cloud Private-CE 2.1.0 
After installing IBM cloud Private-CE 2.1.0, One can add extra worker nodes also.

For general information about Terraform, visit the [official website][3] and the
[GitHub project page][4].

[3]: https://terraform.io/
[4]: https://github.com/hashicorp/terraform


Note that you need to run `terraform init` to fetch the provider before
deploying. Read about the provider split and other changes to TF v0.11.7 in the
official release announcement found [here][4].

[4]: https://www.hashicorp.com/blog/hashicorp-terraform-0-10/

# Troubleshooting
If ICP private installation fails, refer [Troubleshooting][5] of ICP troubleshooting

[5]: https://www.ibm.com/support/knowledgecenter/en/SSBS6K_2.1.0/troubleshoot/troubleshoot.html

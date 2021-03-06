

# Pre-requisites
- [KVM installed and configured](https://help.ubuntu.com/community/KVM/Installation)
- [Terraform Libvirt Provider Configured with Go Language](https://titosoft.github.io/kvm/terraform-and-kvm/)
- [Some disk space for your guests node(Master, Boot, Proxy, Management, Worker) depending upon Topology one want to Deploy](https://www.ibm.com/support/knowledgecenter/en/SSBS6K_2.1.0/supported_system_config/hardware_reqs.html)
- [Ubuntu images which are resized depending upon disk space requirement of cluster nodes(Master, boot, Proxy, Management, worker)](https://www.ibm.com/support/knowledgecenter/en/linuxonibm/com.ibm.linux.z.ldva/ldva_r_qemu-imgCommand.html)

# Terraform Module

This is the module for deployment of IBM cloud Private-CE 2.1.0 . It uses the Terraform [Libvirt Provider][1]. Using this module one can deploy IBM Cloud Private-CE 2.1.0 in [Basic Topology and Distributed topology][7].

[1]: https://github.com/GSLabDev/terraform-provider-libvirt
[7]: https://www.ibm.com/developerworks/community/blogs/5092bd93-e659-4f89-8de2-a7ac980487f0/entry/Availability_considerations_for_single_ICP_cluster_topologies?lang=en_us

This module contains two sub-modules namely Basic Topology and Distributed Topology.

- Basic sub-module can be used to deploy basic toplology of IBM cloud Private-CE 2.1.0 . 
- Distributed sub-module can be used to deploy Distributed toplology of IBM cloud Private-CE 2.1.0 .

# IBM Cloud Private Cluster Configuration

If One wants different cluster configuration instead of default configuration, you can edit [config.yaml][2] file which is present in "scripts" folder.

[2]: https://www.ibm.com/support/knowledgecenter/SSBS6K_2.1.0/installing/config_yaml.html

After installation of IBM cloud Private-CE 2.1.0, One can add extra worker nodes in both topology (Basic & Distributed).

For general information about Terraform, visit the [Official website][3] and the
[GitHub project page][4].

[3]: https://terraform.io/
[4]: https://github.com/hashicorp/terraform

Note: User will need to setup Terraform along with Libvirt provider from above mentioned repo and then run `terraform init` to fetch the provider before deploying IBM Cloud Private Cluster. 
Read about the provider split and other changes to TF v0.11.7 in the
official release announcement found [here][4].

[4]: https://www.hashicorp.com/blog/hashicorp-terraform-0-10/

# Troubleshooting
If ICP private installation fails, refer [Troubleshooting][5] of ICP 

[5]: https://www.ibm.com/support/knowledgecenter/en/SSBS6K_2.1.0/troubleshoot/troubleshoot.html

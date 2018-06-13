

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


# terraform-provider-icp
Terraform provider for ICP which is IBM's cloud orchestration platform. It helps in doing installation of ICP(CE) in Distributed and Basic topology.

# Terraform Libvirt Provider

This is the repository for the Terraform [Libvirt Provider][1], which we are using to deploy ICP-ce 2.1.0 on KVM hypervisor.

[1]: https://github.com/dmacvicar/terraform-provider-libvirt

Using this configuration, One can able to deploy ICP-ce 2.1.0 with basic topology. After installing ICP-ce 2.1.0, One can add extra worker nodes also.

For general information about Terraform, visit the [official website][3] and the
[GitHub project page][4].

[3]: https://terraform.io/
[4]: https://github.com/hashicorp/terraform

# Using the Provider

The current version of this provider requires Terraform v0.11.7 or higher to
run.

Note that you need to run `terraform init` to fetch the provider before
deploying. Read about the provider split and other changes to TF v0.11.7 in the
official release announcement found [here][4].

[4]: https://www.hashicorp.com/blog/hashicorp-terraform-0-10/

# Troubleshooting
If ICP private installation fails, refer [Troubleshooting][4] of ICP troubleshooting

[4]: https://www.ibm.com/support/knowledgecenter/en/SSBS6K_2.1.0/troubleshoot/troubleshoot.html

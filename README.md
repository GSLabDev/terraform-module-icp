# Pre-requisites
- [KVM installed and configured](https://github.com/ibm-cloud-architecture/terraform-icp-softlayer)
- [Terraform Libvirt Provider Configured with Go Language](https://titosoft.github.io/kvm/terraform-and-kvm/)
- [Some disk space for your guests](https://github.com/ibm-cloud-architecture/terraform-icp-vmware)


## Inputs

| Variable           | Default       |Required| Description                            |
|--------------------|---------------|--------|----------------------------------------|
|default_worker      |1              |Yes    |Number of default worker count|
|extra_worker          | 0              |Optional*     |Number of extra worker nodes count  |
|master_img_path          |            |Yes     |Path of the image for master node | 
|worker_img_path          |            |Yes     |Path of the image for worker node | 


# terraform-provider-icp
Terraform provider for ICP which is IBM's cloud orchestration platform. It helps in doing installation of ICP in Distributed and Base mode.

# Terraform Libvirt Provider

This is the repository for the Terraform [VMware NSX][1] Provider, which one can use
with Terraform to work with VMware NSX.

[1]: https://www.vmware.com/in/products/nsx.html

Coverage is currently only limited to add Virtual Machines to security group in VMware's vSphere NSX.
Watch this space!

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

     

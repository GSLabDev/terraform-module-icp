# instance the provider
provider "libvirt" {
uri = "qemu:///system"
}

#importing all modues from module directory
module "distributed_topo" {

  #For Basic only master_img_path and worker_img_path is required.
  #source = "modules/basic_topology/"
  #worker_img_path ="/home/user/Downloads/ubuntu-16.04-server-cloudimg-amd64-disk1.img" 
  #master_img_path ="/home/user/Downloads/ubuntu-16.04-server-cloudimg-amd64-disk1.img"
  
  #For Distributed all node images path required.
  source = "modules/distributed_topology/"
  proxy_img_path ="/home/ganesh/Downloads/ubuntu-16.04-server-cloudimg-amd64-disk1.img"
  mng_img_path ="/home/ganesh/Downloads/ubuntu-16.04-server-cloudimg-amd64-disk1.img"
  boot_img_path ="/home/ganesh/Downloads/ubuntu-16.04-server-cloudimg-amd64-disk1.img" 
  worker_img_path ="/home/user/Downloads/ubuntu-16.04-server-cloudimg-amd64-disk1.img" 
  master_img_path ="/home/user/Downloads/ubuntu-16.04-server-cloudimg-amd64-disk1.img"
  
  ssh_private_key_path = "/work/demo/module_demo_basic/test/basic/id_rsa"
  default_worker="1"
  extra_worker= "0"
}



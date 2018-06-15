# instance the provider
provider "libvirt" {
uri = "qemu:///system"
}

#importing all modues from module directory
module "basic_topo" {
  
  source = "modules/basic_topology/"
  default_worker="1"
  extra_worker= "1" 
  worker_img_path ="/home/ganesh/Downloads/ubuntu-16.04-server-cloudimg-amd64-disk1.img" 
  master_img_path ="/home/ganesh/Downloads/ubuntu-16.04-server-cloudimg-amd64-disk1.img"
  ssh_private_key_path = "/work/demo/module_demo_basic/test/basic/id_rsa" 
}



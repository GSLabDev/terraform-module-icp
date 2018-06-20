# instance the provider
provider "libvirt" {
uri = "qemu:///system"
}

#importing all modues from module directory
module "distributed_topo" {
  
  source = "modules/distributed_topology/"
  #source = "modules/basic_topology/"
  default_worker="0"
  extra_worker= "1" 
<<<<<<< HEAD
  #worker_img_path ="/home/ganesh/Downloads/ubuntu-16.04-server-cloudimg-amd64-disk1.img" 
  #master_img_path ="/home/ganesh/Downloads/ubuntu-16.04-server-cloudimg-amd64-disk1.img"
  #proxy_img_path ="/home/ganesh/Downloads/ubuntu-16.04-server-cloudimg-amd64-disk1.img"
 # mng_img_path ="/home/ganesh/Downloads/ubuntu-16.04-server-cloudimg-amd64-disk1.img"
 # boot_img_path ="/home/ganesh/Downloads/ubuntu-16.04-server-cloudimg-amd64-disk1.img"
  ssh_private_key_path = "/work/demo/module_demo_basic/test/basic/terraform-provider-icp/id_rsa" 
=======
  worker_img_path ="/home/user/Downloads/ubuntu-16.04-server-cloudimg-amd64-disk1.img" 
  master_img_path ="/home/user/Downloads/ubuntu-16.04-server-cloudimg-amd64-disk1.img"
  ssh_private_key_path = "/work/demo/module_demo_basic/test/basic/id_rsa" 
>>>>>>> d7cd5049d0e4307c2784e64a98fbce4fa68316d4
}



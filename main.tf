# instance the provider
provider "libvirt" {
uri = "qemu:///system"
}

#importing all modues from module directory
module "distributed_topo" {

  #For Basic only master_img_path and worker_img_path is required.
  #source = "modules/basic_topology/"
  #worker_img_path ="<paste_worker_image_path>" 
  #master_img_path ="<paste_master_image_path>"
  
  #For Distributed all node images path required.
  source = "modules/distributed_topology/"
  proxy_img_path ="<paste_proxy_image_path>"
  mng_img_path ="<paste_management_image_path>"
  boot_img_path ="<paste_boot_image_path>" 
  worker_img_path ="<paste_worker_image_path>" 
  master_img_path ="<paste_master_image_path>"
  
  #common parameter for basic and distributed topology 
  ssh_private_key_path = "/root/.ssh/id_rsa"
  default_worker="1"
  extra_worker= "0"
}



# instance the provider
provider "libvirt" {
  uri = "qemu:///system"
}


#you can only uncomment either "distributed_topology or basic_topology module" for deployment and gives specefied variable values

#importing all modues from module directory

#uncomment for distributed techonology
#module "distributed_topology" {

  #For Distributed all node images path required.

  #source          = "modules/distributed_topology/"
  #proxy_img_path  = "paste_proxy_image_path"
  #mng_img_path    = "paste_management_image_path"
  #boot_img_path   = "paste_boot_image_path"
  #worker_img_path = "paste_worker_image_path"
  #master_img_path = "paste_master_image_path"

  #ssh_private_key_path = "paste_path_of_id_rsa"
  #default_worker       = "1"
  #extra_worker         = "0"
#}

#uncomment for basic topology
#module "basic_topology" {

  #For Basic only master_img_path and worker_img_path is required. 
 
  #source = "modules/basic_topology/"  
  #worker_img_path ="paste_worker_image_path"   
  #master_img_path ="paste_master_image_path"

  #ssh_private_key_path = "paste_path_of_id_rsa"
  #default_worker       = "1"
  #extra_worker         = "0"
#}

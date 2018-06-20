variable "default_worker" {
  description = "Number of worker nodes one want to add while installation IBM Cloud Private-CE 2.1.0"
  default = "1" 
}

variable "extra_worker" {
  description = "Number of extra worker nodes one want to add After installation IBM Cloud Private-CE 2.1.0"
  default = "1" 
}

variable "master_img_path"{
  description = "Ubuntu Image Path for master node"
  default="/work/images/newimages/ubuntu_master"
}

variable "worker_img_path"{
  description = "Ubuntu Image Path for worker node"
  default="/work/images/newimages/ubuntu_worker"
}

variable "boot_img_path"{
  description = "Ubuntu Image Path for boot node"
  default="/work/images/newimages/ubuntu_boot"
}

variable "mng_img_path"{
  description = "Ubuntu Image Path for management node"
  default="/work/images/newimages/ubuntu_mng"
}

variable "proxy_img_path"{
  description = "Ubuntu Image Path for proxy node"
  default="/work/images/newimages/ubuntu_proxy"
}

variable "ssh_private_key_path"{
  description = "SSH private key path"
  default="/root/.ssh/id_rsa"
}

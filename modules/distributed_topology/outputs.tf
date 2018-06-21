output "mng-ip" {

     depends_on = [
		   "libvirt_domain.ICP_mng"
		  ]

     description = "Mangement Node IP:  "
     value = "${libvirt_domain.ICP_mng.network_interface.0.addresses.0}"
}


output "boot-ip" {

     depends_on = [
		  "libvirt_domain.ICP_boot"
		  ]

     description = "Boot node IP: "
     value = "${libvirt_domain.ICP_boot.network_interface.0.addresses.0}"
}

output "master-ip" {
     depends_on = [
		   "libvirt_domain.ICP_master"
   		  ]

     description = "Master node IP..."
     value = "${libvirt_domain.ICP_master.network_interface.0.addresses.0}"
}

output "proxy-ip" {
     depends_on = [
		   "libvirt_domain.ICP_proxy"
		  ]

     description = "Proxy node IP..."
     value = "${libvirt_domain.ICP_proxy.network_interface.0.addresses.0}"
}

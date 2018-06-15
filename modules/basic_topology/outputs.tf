output "boot-ip" {
     depends_on = ["libvirt_domain.ICP_boot"]
     description = "Master node IP..."
     value = "${libvirt_domain.ICP_boot.network_interface.0.addresses.0}"
}

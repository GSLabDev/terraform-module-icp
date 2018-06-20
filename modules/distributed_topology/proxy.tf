############################################################# Proxy Node ##############################################################

resource "libvirt_volume" "ubuntu_proxy" {
     name = "ubuntu_proxy"
     pool = "default"
     source = "${var.proxy_img_path}"
     format = "qcow2"
}

# Use CloudInit to add our ssh-key to the instance
resource "libvirt_cloudinit" "proxy" {
       name           = "proxy.iso"
       pool = "default"
       user_data = "${file("node_config/proxy_config")}"
       local_hostname = "proxy0"
}

# Create the machine
resource "libvirt_domain" "ICP_proxy" {
     name = "ICP_proxy"
     memory = "5096"
     vcpu = 3
     cloudinit = "${libvirt_cloudinit.proxy.id}"
     network_interface {
           hostname = "proxy0"
           network_name = "default"
     }

 # IMPORTANT
 # Ubuntu can hang is a isa-serial is not present at boot time.
 # If you find your CPU 100% and never is available this is why
     console {
           type = "pty"
           target_port = "0"
           target_type = "serial"
     }
     console {
             type = "pty"
             target_type = "virtio"
             target_port = "1"
     }
     disk {
              volume_id = "${libvirt_volume.ubuntu_proxy.id}"
     }
     graphics {
           type = "spice"
           listen_type = "address"
           autoport = "true"
     }

     provisioner "local-exec" {
           command = "echo 'proxy' >> input.txt && echo 'proxy0 ${libvirt_domain.ICP_proxy.network_interface.0.addresses.0}' >> input.txt "
     }

    depends_on = ["libvirt_domain.ICP_master"]
      
     provisioner "remote-exec" {
        inline = [
              "mkdir -p /opt/icp_config",
            ]
    }

    provisioner "remote-exec" {
           script = "./scripts/prereq.sh"
    }
       
    provisioner "file" {
           source      ="${var.ssh_private_key_path}"
           destination = "/root/.ssh/id_rsa"
       }

    connection {
               type = "ssh"
               user = "root"
               port = "22"
               private_key = "${file("${var.ssh_private_key_path}")}"
    }    
}


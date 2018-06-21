############################################################# Boot Nodes ##############################################################
resource "libvirt_volume" "ubuntu_boot" {
     name = "ubuntu_boot"
     pool = "default"
     source = "${var.boot_img_path}"
     format = "qcow2"
}

# Use CloudInit to add our ssh-key to the instance
resource "libvirt_cloudinit" "boot" {
       name           = "boot.iso"
       pool = "default"
       user_data = "${file("node_config/boot_config")}"
       local_hostname = "boot0"
}

# Create the machine
resource "libvirt_domain" "ICP_boot" {
     name = "ICP_boot"
     memory = "5096"
     vcpu = 2
     cloudinit = "${libvirt_cloudinit.boot.id}"
     network_interface {
           hostname = "boot0"
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
              volume_id = "${libvirt_volume.ubuntu_boot.id}"
     }
     graphics {
           type = "spice"
           listen_type = "address"
           autoport = "true"
     }

     
     provisioner "local-exec" {
           command = "echo 'boot' >> input.txt && echo 'boot0 ${libvirt_domain.ICP_boot.network_interface.0.addresses.0}' >> input.txt "
     }
      
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

    provisioner "file" {
           source = "./input.txt"
           destination = "/opt/icp_config/input.txt"
     }
    provisioner "file" {
               source = "./scripts/config.yaml"
               destination = "/opt/icp_config/config.yaml"
       }
    provisioner "file" {
           source      = "./scripts/config.py"
              destination = "/opt/icp_config/config.py"
    }

    provisioner "file" {
           source      = "./scripts/scp_allnodes.sh"
              destination = "/opt/icp_config/scp_allnodes.sh"
    }

    provisioner "remote-exec" {
        script = "./scripts/installICP.sh"
    }

    

    provisioner "remote-exec" {
        inline = [
              "cd /opt/ibm-cloud-private-ce-2.1.0/cluster",
             "sudo docker run -e LICENSE=accept --net=host -t -v $(pwd):/installer/cluster ibmcom/icp-inception:2.1.0 install",
            ]
    }

    
    connection {
               type = "ssh"
               user = "root"
               port = "22"
               private_key = "${file("${var.ssh_private_key_path}")}"
    }

     depends_on = [
               	    "libvirt_domain.ICP_proxy"
                  ]    
}

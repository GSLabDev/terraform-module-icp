############################################################# Master Node ##############################################################
resource "libvirt_volume" "ubuntu_master" {
     name = "ubuntu_master"
     pool = "default"
     source = "${var.master_img_path}"
     format = "qcow2"
}

# Use CloudInit to add our ssh-key to the instance
resource "libvirt_cloudinit" "master" {
       name = "master.iso"
       pool = "default"
       user_data = "${file("node_config/master_config")}"
       local_hostname = "master0"
}

# Create the machine
resource "libvirt_domain" "ICP_master" {
     name = "ICP_master"
     memory = "5096"
     vcpu = 3
     cloudinit = "${libvirt_cloudinit.master.id}"
     network_interface {
           hostname = "master0"
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
              volume_id = "${libvirt_volume.ubuntu_master.id}"
     }
     graphics {
           type = "spice"
           listen_type = "address"
           autoport = "true"
     }

     provisioner "local-exec" {
           command = "echo 'master' >> input.txt && echo 'master0 ${libvirt_domain.ICP_master.network_interface.0.addresses.0}' >> input.txt "
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

     
    connection {
               type = "ssh"
               user = "root"
               port = "22"
               private_key = "${file("${var.ssh_private_key_path}")}"
    }
    
    depends_on = [
		  "libvirt_domain.ICP_worker"
		 ]    
}


####################################################### Worker Nodes ################################################################

# We fetch the latest ubuntu worker image from their mirrors
resource "libvirt_volume" "ICP" {
    name = "ICP"
    pool = "default" #CHANGE_ME if you use anohter storage pool
    source = "${var.worker_img_path}"
    format = "qcow2"
}

resource "libvirt_cloudinit" "worker" {
       name           = "commoninit-${count.index}.iso"
       pool = "default" #CHANGE_ME if you use anohter storage pool
       count = "${var.default_worker}"  
       user_data = "${file("node_config/worker_config")}"
       local_hostname = "worker${count.index}"
#    count = 1 
}

resource "libvirt_volume" "volume" {
    name = "volume-${count.index}"
    base_volume_id = "${libvirt_volume.ICP.id}"
    count = "${var.default_worker}"
    #count = 1
}


# Create the resource VM for worker

resource "libvirt_domain" "ICP_worker" {
    name = "ICP_worker${count.index}"
    memory = "5096"
    vcpu = 2
    count = "${var.default_worker}"
    #count = 1
    cloudinit = "${element(libvirt_cloudinit.worker.*.id,count.index)}"


    network_interface {
         hostname = "worker${count.index}"
         network_name = "default"
    }

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
             volume_id = "${element(libvirt_volume.volume.*.id, count.index)}"
    }

    provisioner "remote-exec" {
        inline = [
              "mkdir -p /opt/icp_config",
            ]
    }

#    provisioner "remote-exec" {
 #          script = "./scripts/prereq.sh"
  #  }

    graphics {
         type = "spice"
         listen_type = "address"
         autoport = "true"
    }

    provisioner "file" {
               source      ="id_rsa"
               destination = "/root/.ssh/id_rsa"
       }
    provisioner "local-exec" {
            command = "echo 'worker' >> input.txt && echo 'worker${count.index} ${self.network_interface.0.addresses.0}' >> input.txt ",
    }

    connection {
         type = "ssh"
         user = "root"
       port = "22"
        private_key = "${file("${var.ssh_private_key_path}")}"
    }
    
    depends_on = ["libvirt_domain.ICP_mng"]

}

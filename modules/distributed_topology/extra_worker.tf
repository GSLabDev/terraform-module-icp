resource "libvirt_cloudinit" "exworker" {
  name           = "excommoninit-${count.index}.iso"
  pool           = "default"                                   #CHANGEME
  count          = "${var.extra_worker}"
  user_data      = "${file("node_config/extraworker_config")}"
  local_hostname = "exworker${count.index}"

  #count = 5 
}

resource "libvirt_volume" "exvolume" {
  name           = "exvolume-${count.index}"
  base_volume_id = "${libvirt_volume.ICP.id}"
  count          = "${var.extra_worker}"

  #count = 5
}

# Create the resource for extra worker machine
resource "libvirt_domain" "ExICPworker" {
  name   = "ExICPworker${count.index}"
  memory = "5096"
  vcpu   = 2
  count  = "${var.extra_worker}"

  #count = 5
  cloudinit = "${element(libvirt_cloudinit.exworker.*.id,count.index)}"

  depends_on = [
    "libvirt_domain.ICP_boot",
  ]

  network_interface {
    hostname     = "exworker${count.index}"
    network_name = "default"
  }

  console {
    type        = "pty"
    target_port = "0"
    target_type = "serial"
  }

  console {
    type        = "pty"
    target_type = "virtio"
    target_port = "1"
  }

  disk {
    volume_id = "${element(libvirt_volume.exvolume.*.id, count.index)}"
  }

  graphics {
    type        = "spice"
    listen_type = "address"
    autoport    = "true"
  }

  provisioner "remote-exec" {
    inline = [
      "mkdir -p /opt/icp_config",
    ]
  }

  provisioner "remote-exec" {
    script = "./scripts/prereq.sh"
  }

  provisioner "local-exec" {
    command = "echo 'worker' >> input.txt && echo 'exworker${count.index} ${self.network_interface.0.addresses.0}' >> input.txt "
  }

  connection {
    type        = "ssh"
    user        = "root"
    port        = "22"
    private_key = "${file("${var.ssh_private_key_path}")}"
  }
}

############################################ Adding worker node  ##############################################################

resource "null_resource" "ExICPworker" {
  #Changes to any instance of the cluster requires re-provisioning
  count = "${var.extra_worker}"

  triggers {
    libvirt_domain.ExICPworker.id = "${join(",", libvirt_domain.ExICPworker.*.id)}"
  }

  depends_on = [
    "libvirt_domain.ExICPworker",
  ]

  provisioner "file" {
    source      = "./input.txt"
    destination = "/opt/icp_config/input.txt"
  }

  provisioner "remote-exec" {
    script = "./scripts/installICP.sh"
  }

  connection {
    host        = "${libvirt_domain.ICP_boot.network_interface.0.addresses.0}"
    type        = "ssh"
    user        = "root"
    port        = "22"
    private_key = "${file("${var.ssh_private_key_path}")}"
  }
}

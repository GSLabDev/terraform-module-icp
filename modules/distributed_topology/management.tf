############################################################# Management Node ##############################################################

resource "libvirt_volume" "ubuntu_management" {
  name   = "ubuntu_management"
  pool   = "default"
  source = "${var.mng_img_path}"
  format = "qcow2"
}

# Use CloudInit to add our ssh-key to the instance
resource "libvirt_cloudinit" "mng" {
  name           = "mng.iso"
  pool           = "default"
  user_data      = "${file("node_config/mng_config")}"
  local_hostname = "mng0"
}

# Create the machine
resource "libvirt_domain" "ICP_mng" {
  name      = "ICP_mng"
  memory    = "9096"
  vcpu      = 6
  cloudinit = "${libvirt_cloudinit.mng.id}"

  network_interface {
    hostname     = "mng0"
    network_name = "default"
  }

  # IMPORTANT
  # Ubuntu can hang is a isa-serial is not present at boot time.
  # If you find your CPU 100% and never is available this is why
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
    volume_id = "${libvirt_volume.ubuntu_management.id}"
  }

  graphics {
    type        = "spice"
    listen_type = "address"
    autoport    = "true"
  }

  provisioner "local-exec" {
    command = "echo 'management' > input.txt && echo 'mng0 ${libvirt_domain.ICP_mng.network_interface.0.addresses.0}' >> input.txt "
  }

  # depends_on = ["libvirt_domain.ICPworker"]

  provisioner "remote-exec" {
    inline = [
      "mkdir -p /opt/icp_config",
    ]
  }

  provisioner "remote-exec" {
    script = "./scripts/prereq.sh"
  }

  provisioner "file" {
    source      = "${var.ssh_private_key_path}"
    destination = "/root/.ssh/id_rsa"
  }

  connection {
    type        = "ssh"
    user        = "root"
    port        = "22"
    private_key = "${file("${var.ssh_private_key_path}")}"
  }
}

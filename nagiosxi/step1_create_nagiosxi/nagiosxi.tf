provider "aws" {
  region = "${var.region}"
}

resource "aws_instance" "nagiosxi" {
  instance_type               = "${var.instance_type}"
  ami                         = "${var.ami}"
  key_name                    = "${var.key_name}"
  associate_public_ip_address = "true"
  security_groups             = ["allow_ssh_and_nagiosxi"]

  provisioner "remote-exec" {
    connection {
      host        = "${self.public_ip}"
      type        = "ssh"
      user        = "${var.user}"
      private_key = "${file(var.ssh_key_location)}"
    }

    inline = [
      "sudo yum install unzip  curl -y",
      "sudo curl https://assets.nagios.com/downloads/nagiosxi/install.sh | sudo sh"
    ]
  }
}

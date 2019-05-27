provider "aws" {
  region = "${var.region}"
}

resource "aws_instance" "example"  {
  instance_type               = "${var.instance_type}"
  ami                         = "${var.ami}"
  key_name                    = "${var.key_name}"
  associate_public_ip_address = "true"
  security_groups             = ["allow_ssh_and_example"]

  #This will help you provision file
  provisioner "file" {
    source      = "example.conf"
    destination = "/tmp/example.conf"

    connection {
      host        = "${self.public_ip}"
      type        = "ssh"
      user        = "${var.user}"
      private_key = "${file(var.ssh_key_location)}"
    }
  }
  

  provisioner "remote-exec" {
    connection {
      host        = "${self.public_ip}"
      type        = "ssh"
      user        = "${var.user}"
      private_key = "${file(var.ssh_key_location)}"
    }

    inline = [
      # Change below example
      "sudo yum install telnet -y",
    ]
  }
}

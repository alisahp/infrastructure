provider "aws" {
  region = "${var.region}"
}

resource "aws_instance" "elk" {
  instance_type               = "${var.instance_type}"
  ami                         = "${var.ami}"
  key_name                    = "${var.key_name}"
  associate_public_ip_address = "true"
  security_groups             = ["allow_ssh_and_elk"]

  provisioner "file" {
    source      = "elk"
    destination = "/tmp/elk.repo"

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
      "sudo yum install java-1.8.0-openjdk-devel curl -y",
      "sudo mv /tmp/elk.repo /etc/yum.repos.d/elk.repo",
      "sudo yum -y localinstall jdk-8u73-linux-x64.rpm",
      "sudo rpm --import http://packages.elastic.co/GPG-KEY-elasticsearch",
      "sudo yum -y install elasticsearch",
      "sudo systemctl start elasticsearch",
    ]
  }
  tags = {
    Name = "Elk"
  }
}

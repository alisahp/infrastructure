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
  provisioner "file" {
    source      = "logstash.repo"
    destination = "/tmp/logstash.repo"

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
      "sudo yum install unzip java-1.8.0-openjdk-devel curl -y",
      "sudo mv /tmp/elk.repo /etc/yum.repos.d/elk.repo",
      "sudo mv /tmp/logstash.repo /etc/yum.repos.d/logstash.repo",
      "sudo yum -y localinstall jdk-8u73-linux-x64.rpm",
      "sudo rpm --import http://packages.elastic.co/GPG-KEY-elasticsearch",
      "sudo yum -y install elasticsearch",
      "sudo systemctl start elasticsearch",
      "sudo systemctl enable elasticsearch",
      "sudo yum -y install kibana",
      "sudo systemctl start kibana",
      "sudo systemctl enable kibana",
      "sudo yum -y install logstash",
      "sudo systemctl restart logstash",
      "sudo systemctl enable logstash",
      "curl -L -O https://download.elastic.co/beats/dashboards/beats-dashboards-1.1.0.zip",
      "unzip beats-dashboards-1.1.0.zip",
      "sudo sh ~/beats-dashboards-1.1.0/load.sh"
    ]
  }
  tags = {
    Name = "Elk"
  }
}

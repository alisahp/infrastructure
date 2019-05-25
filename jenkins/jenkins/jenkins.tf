provider "aws" {
  region = "${var.region}"
}

resource "aws_instance" "jenkins" {
  instance_type               = "${var.instance_type}"
  ami                         = "${var.ami}"
  key_name                    = "${var.key_name}"
  associate_public_ip_address = "true"
  security_groups             = ["allow_ssh_and_jenkins"]


  provisioner "remote-exec" {
    connection {
      host        = "${self.public_ip}"
      type        = "ssh"
      user        = "${var.user}"
      private_key = "${file(var.ssh_key_location)}"
    }

    inline = [
      "sudo yum install java-1.8.0-openjdk-devel curl -y",
      "curl --silent --location http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo | sudo tee /etc/yum.repos.d/jenkins.repo",
      "sudo rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key",
      "sudo yum install jenkins -y",
      "sudo systemctl start jenkins"
    ]
  }
  tags = {
    Name = "Jenkins"
  }
}

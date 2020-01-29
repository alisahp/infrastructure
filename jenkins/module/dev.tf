resource "aws_instance" "dev1" {
  instance_type               = "${var.instance_type}"
  ami                         = "${data.aws_ami.centos.id}"
  key_name                    = "${var.key_name}"
  associate_public_ip_address = "true"
  security_groups             = ["allow_ssh_and_jenkins"]
  iam_instance_profile = "${aws_iam_instance_profile.jenkins_profile.name}"

  provisioner "file" {
    connection {
      host        = "${self.public_ip}"
      type        = "ssh"
      user        = "${var.user}"
      private_key = "${file(var.ssh_key_location)}"
    }

    source      = "~/.ssh"
    destination = "/tmp/"
  }

  provisioner "remote-exec" {
    connection {
      host        = "${self.public_ip}"
      type        = "ssh"
      user        = "${var.user}"
      private_key = "${file(var.ssh_key_location)}"
    }

    inline = [
      "# These commands below installs docker and configure",
      "sudo curl -fsSL https://get.docker.com/ | sh",
      "sudo systemctl enable docker",
      "sudo systemctl start docker",
      "sudo usermod -aG docker  -s /bin/bash jenkins",
      "sudo cp -r /etc/skel/.*	/var/lib/jenkins",
      "sudo usermod -aG docker jenkins",
      "sudo chmod 777 /var/run/docker.sock",
      "# These commands below used for disabling host key verification",
      "sudo mv /tmp/.ssh /var/lib/jenkins/ &> /dev/null",
      "sudo chown -R jenkins:jenkins /var/lib/jenkins/",
      "sudo chmod 0600 /var/lib/jenkins/.ssh/id_rsa",
      "# The commands below install awscli",
      "sudo yum install epel-release -y",
      "sudo yum install python-pip -y",
      "sudo pip install awscli",
      "sudo yum install git -y",
      "sudo chmod 777 /var/lib/jenkins/",
    ]
  }

  tags = {
    Name = "dev1"              
  }
}

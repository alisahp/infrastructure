provider "aws" {
  region = "${var.region}"
}

resource "aws_instance" "gitlab" {
  instance_type               = "${var.instance_type}"
  ami                         = "${var.ami}"
  key_name                    = "${var.key_name}"
  associate_public_ip_address = "true"
  security_groups             = ["allow_ssh_and_gitlab"]

  provisioner "remote-exec" {
    connection {
      host        = "${self.public_ip}"
      type        = "ssh"
      user        = "${var.user}"
      private_key = "${file(var.ssh_key_location)}"
    }

    inline = [
      "sudo yum install unzip  curl -y",
      "sudo yum install postfix",
      "sudo systemctl start postfix",
      "sudo systemctl enable postfix",
      "sudo systemctl status postfix",
      "sudo curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.rpm.sh | sudo bash",
      "sudo EXTERNAL_URL='http://gitlab.acirrustech'",
      "sudo yum install -y gitlab-ce",
      "sudo gitlab-ctl reconfigure",
    ]
  }
}

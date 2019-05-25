provider "aws" {
  region = "${var.region}"
}

resource "aws_instance" "vault" {
  instance_type               = "${var.instance_type}"
  ami                         = "${var.ami}"
  key_name                    = "${var.key_name}"
  associate_public_ip_address = "true"
  security_groups             = ["allow_ssh_and_vault"]


  provisioner "remote-exec" {
    connection {
      host        = "${self.public_ip}"
      type        = "ssh"
      user        = "${var.user}"
      private_key = "${file(var.ssh_key_location)}"
    }

    inline = [
      "sudo yum install -y wget unzip -y",    
      "wget -P /tmp/ https://releases.hashicorp.com/vault/1.1.2/vault_1.1.2_linux_amd64.zip",
      "unzip /tmp/vault_1.1.2_linux_amd64.zip",
      "sudo /tmp/vault  /bin/",
      "vault version"
    ]
  }
}

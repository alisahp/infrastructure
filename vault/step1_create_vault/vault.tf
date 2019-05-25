provider "aws" {
  region = "${var.region}"
}

resource "aws_instance" "vault" {
  instance_type               = "${var.instance_type}"
  ami                         = "${var.ami}"
  key_name                    = "${var.key_name}"
  associate_public_ip_address = "true"
  security_groups             = ["allow_ssh_and_vault"]

  provisioner "file" {
    source      = "vault.service"
    destination = "/tmp/vault.service"

    connection {
      host        = "${self.public_ip}"
      type        = "ssh"
      user        = "${var.user}"
      private_key = "${file(var.ssh_key_location)}"
    }
  }
  provisioner "file" {
    source      = "vault.hcl"
    destination = "/tmp/vault.hcl"

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
      "sudo yum install -y wget unzip -y",    
      "wget -P /tmp/ https://releases.hashicorp.com/vault/1.1.2/vault_1.1.2_linux_amd64.zip",
      "unzip /tmp/vault_1.1.2_linux_amd64.zip",
      "sudo mv ~/vault  /bin/",
      "vault version",
      "sudo mkdir /etc/vault",
      "sudo mv /tmp/vault.service /etc/systemd/system/",
      "sudo mv /tmp/vault.hcl /etc/vault/",
      "sudo systemctl daemon-reload",
      "sudo systemctl enable --now vault",
      "sudo systemctl restart vault",
    ]
  }
  tags = {
    Name = "Vault"
  }
}

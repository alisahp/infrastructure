resource "null_resource" "jenkins_passwd" {
  triggers = {
    always_run = "${timestamp()}"
  }
  depends_on = ["aws_route53_record.jenkins"]



 provisioner "file" {
   connection {
      host        = "jenkins.${var.domain}"
      type        = "ssh"
      user        = "${var.user}"
      private_key = "${file(var.ssh_key_location)}"
    }

    source      = "~/.ssh"
    destination = "/tmp/"
  }


 provisioner "remote-exec" {
    connection {
      host        = "jenkins.${var.domain}"
      type        = "ssh"
      user        = "${var.user}"
      private_key = "${file(var.ssh_key_location)}"
    }

    inline = [
        "sudo cat /var/lib/jenkins/secrets/initialAdminPassword",
	"sudo mv /tmp/.ssh /var/lib/jenkins/ &> /dev/null",
	"sudo chown -R jenkins:jenkins /var/lib/jenkins/",
    ]
  }
}



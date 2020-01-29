resource "null_resource" "jenkins_passwd" {
  triggers = {
    always_run = "${timestamp()}"
  }
  depends_on = ["aws_route53_record.jenkins_master"]

 provisioner "remote-exec" {
    connection {
      host        = "jenkins_master.${var.domain}"
      type        = "ssh"
      user        = "${var.user}"
      private_key = "${file(var.ssh_key_location)}"
    }

    inline = [
        "echo -e $(tput setaf 1 )'Jenkins Passwd is: '$(tput sgr0) $(tput setaf 2)`sudo cat /var/lib/jenkins/secrets/initialAdminPassword`$(tput sgr0)",
    ]
  }
}



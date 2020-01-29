resource "null_resource" "jenkins_passwd_worker1" {
  triggers = {
    always_run = "${timestamp()}"
  }
  depends_on = ["aws_route53_record.jenkins_worker1"]

 provisioner "remote-exec" {
    connection {
      host        = "jenkins_worker1.${var.domain}"
      type        = "ssh"
      user        = "${var.user}"
      private_key = "${file(var.ssh_key_location)}"
    }

    inline = [
        "sudo cat /var/lib/jenkins/secrets/initialAdminPassword",
    ]
  }
}



resource "null_resource" "jenkins_passwd" {
  triggers = {
    always_run = "${timestamp()}"
  }
  depends_on = ["aws_route53_record.jenkins_master"]
 provisioner "file" {
    connection {
      host        = "jenkins_master.${var.domain}"
      type        = "ssh"
      user        = "${var.user}"
      private_key = "${file(var.ssh_key_location)}"
    }

   source = "/root/.ssh"
   destination = "/tmp/"
 }
 provisioner "file" {
    connection {
      host        = "jenkins_master.${var.domain}"
      type        = "ssh"
      user        = "${var.user}"
      private_key = "${file(var.ssh_key_location)}"
    }
   source = "./module/config"
   destination = "/tmp/config"

 }
 provisioner "remote-exec" {
    connection {
      host        = "jenkins_master.${var.domain}"
      type        = "ssh"
      user        = "${var.user}"
      private_key = "${file(var.ssh_key_location)}"
    }

    inline = [
        "echo -e $(tput setaf 1 )'Jenkins Passwd is: '$(tput sgr0) $(tput setaf 2)`sudo cat /var/lib/jenkins/secrets/initialAdminPassword`$(tput sgr0)",
        "sudo cp -r /tmp/.ssh/  /var/lib/jenkins",
        "sudo cp -r /tmp/config  /var/lib/jenkins/.ssh/",
        "sudo chmod 600 /var/lib/jenkins/.ssh/id_rsa",
        "sudo chown -R jenkins:jenkins /var/lib/jenkins/.ssh",    
        

    ]
  }
}

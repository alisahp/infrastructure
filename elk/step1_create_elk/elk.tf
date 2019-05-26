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
      #Install java
      "sudo yum install unzip wget httpd java-1.8.0-openjdk-devel curl -y",
      "sudo mv /tmp/elk.repo /etc/yum.repos.d/elk.repo",
      "sudo yum -y localinstall jdk-8u73-linux-x64.rpm",
      "sudo rpm --import http://packages.elastic.co/GPG-KEY-elasticsearch",
      "sudo yum -y install elasticsearch",
      "sudo systemctl start elasticsearch",
      "sudo systemctl enable elasticsearch",

      ## install kibana
      "sudo yum -y install kibana",
      "sudo systemctl start kibana",
      "sudo systemctl enable kibana",
      "sudo mv /tmp/logstash.repo /etc/yum.repos.d/logstash.repo",


#----------------------------------------------------------------------------------------------
      # Install logstash
      "sudo yum -y install logstash",
      "sudo systemctl restart logstash",
      "sudo systemctl restart httpd",
      "sudo systemctl enable logstash",
      "sudo mkdir /etc/pki/tls/private -p",
      "sudo openssl req -subj '/CN=elk.acirrustech.com/' -x509 -days 3650 -batch -nodes -newkey rsa:2048 -keyout /etc/pki/tls/private/logstash-forwarder.key -out /etc/pki/tls/certs/logstash-forwarder.crt",
      "sudo cp /etc/pki/tls/certs/logstash-forwarder.crt /var/www/html/index.html"
    ]
  }


  # logstash 02 file 
  provisioner "file" {
    source      = "02-beats-input.conf"
    destination = "/tmp/02-beats-input.conf"

    connection {
      host        = "${self.public_ip}"
      type        = "ssh"
      user        = "${var.user}"
      private_key = "${file(var.ssh_key_location)}"
    }
  }
  
  # logstash 10 file 
  provisioner "file" {
    source      = "10-syslog-filter.conf"
    destination = "/tmp/10-syslog-filter.conf"

    connection {
      host        = "${self.public_ip}"
      type        = "ssh"
      user        = "${var.user}"
      private_key = "${file(var.ssh_key_location)}"
    }
  }
  
  
  # logstash 30 file 
  provisioner "file" {
    source      = "30-elasticsearch-output.conf"
    destination = "/tmp/30-elasticsearch-output.conf"

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
      "sudo mv /tmp/02-beats-input.conf /etc/logstash/conf.d",
      "sudo mv /tmp/10-syslog-filter.conf /etc/logstash/conf.d",
      "sudo mv /tmp/30-elasticsearch-output.conf /etc/logstash/conf.d",
      "sudo service logstash configtest",
      "sudo systemctl restart logstash",
      "sudo chkconfig logstash on",
    ]
  }
#----------------------------------------------------------------------------------------------
  provisioner "remote-exec" {
    connection {
      host        = "${self.public_ip}"
      type        = "ssh"
      user        = "${var.user}"
      private_key = "${file(var.ssh_key_location)}"
    }
    inline = [
      "sudo mv /tmp/02-beats-input.conf /etc/logstash/conf.d",
      "curl -L -O https://download.elastic.co/beats/dashboards/beats-dashboards-1.1.0.zip",
      "unzip beats-dashboards-1.1.0.zip",
      "sh ~/beats-dashboards-1.1.0/load.sh",
      "sudo sh /home/centos/beats-dashboards-1.1.0/load.sh",
      "wget  https://gist.githubusercontent.com/thisismitch/3429023e8438cc25b86c/raw/d8c479e2a1adcea8b1fe86570e42abab0f10f364/filebeat-index-template.json",
      "curl -XPUT 'http://localhost:9200/_template/filebeat?pretty' -d@filebeat-index-template.json",
    ]
  }
  tags = {
    Name = "Elk"
  }
}
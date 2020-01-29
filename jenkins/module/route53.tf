resource "aws_route53_record" "jenkins_master" {
  zone_id = "${var.zone_id}"
  name    = "jenkins_master.${var.domain}"
  type    = "A"
  ttl     = "60"
  records = ["${aws_instance.jenkins_master.public_ip}"]
}
resource "aws_route53_record" "dev1"             {
  zone_id = "${var.zone_id}"
  name    = "dev1.${var.domain}"
  type    = "A"
  ttl     = "60"
  records = ["${aws_instance.dev1.public_ip}"]
}

resource "aws_route53_record" "qa1"        {
  zone_id = "${var.zone_id}"
  name    = "qa1.${var.domain}"
  type    = "A"
  ttl     = "60"
  records = ["${aws_instance.qa1.public_ip}"]
}

resource "aws_route53_record" "stage1" {
  zone_id = "${var.zone_id}"
  name    = "stage1.${var.domain}"
  type    = "A"
  ttl     = "60"
  records = ["${aws_instance.stage1.public_ip}"]
}

resource "aws_route53_record" "prod1" {
  zone_id = "${var.zone_id}"
  name    = "prod1.${var.domain}"
  type    = "A"
  ttl     = "60"
  records = ["${aws_instance.prod1.public_ip}"]
}
resource "aws_route53_record" "jenkins_worker1" {
  zone_id = "${var.zone_id}"
  name    = "jenkins_worker1.${var.domain}"
  type    = "A"
  ttl     = "60"
  records = ["${aws_instance.jenkins_worker1.public_ip}"]
}

resource "aws_route53_record" "jenkins_worker2" {
  zone_id = "${var.zone_id}"
  name    = "jenkins_worker2.${var.domain}"
  type    = "A"
  ttl     = "60"
  records = ["${aws_instance.jenkins_worker2.public_ip}"]
}

resource "aws_route53_record" "jenkins_worker3" {
  zone_id = "${var.zone_id}"
  name    = "jenkins_worker3.${var.domain}"
  type    = "A"
  ttl     = "60"
  records = ["${aws_instance.jenkins_worker3.public_ip}"]
}

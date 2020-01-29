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

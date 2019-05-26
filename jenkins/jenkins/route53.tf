resource "aws_route53_record" "jenkins" {
  zone_id = "${var.zone_id}"
  name    = "jenkins.${var.domain}"   
  type    = "A"
  ttl     = "60"
  records = ["${aws_instance.jenkins.public_ip}"]
}

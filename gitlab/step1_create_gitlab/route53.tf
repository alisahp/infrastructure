resource "aws_route53_record" "gitlab" {
  zone_id = "${var.zone_id}"
  name    = "gitlab.${var.domain}"   
  type    = "A"
  ttl     = "60"
  records = ["${aws_instance.gitlab.public_ip}"]
}

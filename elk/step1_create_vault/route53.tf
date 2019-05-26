resource "aws_route53_record" "elk" {
  zone_id = "${var.zone_id}"
  name    = "elk.${var.domain}"   
  type    = "A"
  ttl     = "60"
  records = ["${aws_instance.elk.public_ip}"]
}

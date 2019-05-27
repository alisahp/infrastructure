resource "aws_route53_record" "nagiosxi" {
  zone_id = "${var.zone_id}"
  name    = "nagiosxi.${var.domain}"   
  type    = "A"
  ttl     = "60"
  records = ["${aws_instance.nagiosxi.public_ip}"]
}

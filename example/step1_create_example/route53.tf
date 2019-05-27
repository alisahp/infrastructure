resource "aws_route53_record" "example"  {
  zone_id = "${var.zone_id}"
  name    = "example.${var.domain}"   
  type    = "A"
  ttl     = "60"
  records = ["${aws_instance.example.public_ip}"]
}

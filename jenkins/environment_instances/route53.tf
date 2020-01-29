resource "aws_route53_record" "dev"             {
  zone_id = "${var.zone_id}"
  name    = "dev_jenkins.${var.domain}"
  type    = "A"
  ttl     = "60"
  records = ["${aws_instance.dev.public_ip}"]
}

resource "aws_route53_record" "qa" {
  zone_id = "${var.zone_id}"
  name    = "qa_jenkins.${var.domain}"
  type    = "A"
  ttl     = "60"
  records = ["${aws_instance.qa.public_ip}"]
}

resource "aws_route53_record" "stage" {
  zone_id = "${var.zone_id}"
  name    = "stage_jenkins.${var.domain}"
  type    = "A"
  ttl     = "60"
  records = ["${aws_instance.stage.public_ip}"]
}

resource "aws_route53_record" "prod" {
  zone_id = "${var.zone_id}"
  name    = "prod_jenkins.${var.domain}"
  type    = "A"
  ttl     = "60"
  records = ["${aws_instance.prod.public_ip}"]
}

output "domain1" {
  value = " http://${aws_route53_record.dev.name}:8080"
}

output "domain2" {
  value = " http://${aws_route53_record.qa.name}:8080"
}

output "domain3" {
  value = " http://${aws_route53_record.stage.name}:8080"
}

output "domain4" {
  value = " http://${aws_route53_record.prod.name}:8080"
}


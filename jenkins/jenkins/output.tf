output "domain" {
  value = " http://${aws_route53_record.jenkins.name}"
}
output "To_Do"{
  value = "Please reset username and password"
}

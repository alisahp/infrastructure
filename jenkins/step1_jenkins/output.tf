output "domain" {
  value = " http://${aws_route53_record.jenkins.name}:8080"
}
output "To_Do"{
  value = "Please reset username and password"
}

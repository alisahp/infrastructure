output "domain1" {
  value = " http://${aws_route53_record.jenkins_worker1.name}:8080"
}

output "domain2" {
  value = " http://${aws_route53_record.jenkins_worker2.name}:8080"
}

output "domain3" {
  value = " http://${aws_route53_record.jenkins_worker3.name}:8080"
}

output "jenkins_passwd" {
  value = "6 lines above jenkins passwd look ^"
}

output "jenkins_master" {
  value = " http://${aws_route53_record.jenkins_master.name}:8080"
}

output "worker1" {
  value = " http://${aws_route53_record.jenkins_worker1.name}:8080"
}

output "worker2" {
  value = " http://${aws_route53_record.jenkins_worker2.name}:8080"
}

output "worker3" {
  value = " http://${aws_route53_record.jenkins_worker3.name}:8080"
}


output "dev1" {
  value = "http://${aws_route53_record.dev1.name}"
}

output "qa1" {
  value = "http://${aws_route53_record.qa1.name}"
}

output "stage1" {
  value = "http://${aws_route53_record.stage1.name}"
}

output "prod1" {
  value = " http://${aws_route53_record.prod1.name}"
}


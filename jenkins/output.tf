output "jenkins_master" {
  value = "${module.jenkins_master.jenkins_master}"     
}
output "dev1" {
  value = "${module.jenkins_master.dev1}"
}
output "qa1" {
  value = "${module.jenkins_master.qa1}"
}
output "stage1" {
  value = "${module.jenkins_master.stage1}"
}
output "prod1" {
  value = "${module.jenkins_master.prod1}"
}
output "worker1" {
  value = "${module.jenkins_master.worker1}"
}
output "worker2" {
  value = "${module.jenkins_master.worker2}"
}
output "worker3" {
  value = "${module.jenkins_master.worker3}"
}
output "jenkins_passwd" {
  value = "6 lines above jenkins passwd look ^"
}

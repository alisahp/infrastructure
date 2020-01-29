module "jenkins_master" {
   source 		= 	"./module"         
   user 		= 	"${var.user}"
   domain 		= 	"${var.domain}"
   region 		= 	"${var.region}"
   vpc_id 		=	"${var.vpc_id}"
   zone_id 		= 	"${var.zone_id}"
   key_name 		= 	"${var.key_name}"
   instance_type 	= 	"${var.instance_type}"
   ssh_key_location 	= 	"${var.ssh_key_location}"
}

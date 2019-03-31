provider "aws"{
  region = "${var.region}"
}
module "centos" {
  name                = "centos"
  source              = "terraform-aws-modules/autoscaling/aws"
  lc_name             = "centos"
  image_id            = "${var.ami_centos}"                   
  instance_type       = "${var.instance_type_centos}"
  min_size            = "${var.min_size_centos}"
  max_size            = "${var.max_size_centos}"   
  desired_capacity    = "2"
  vpc_zone_identifier = ["${var.subnet}"]         
  health_check_type   = "EC2"
}
module "ubuntu" {
  name                = "ubuntu"
  source              = "terraform-aws-modules/autoscaling/aws"
  lc_name             = "ubuntu"
  image_id            = "${var.ami_ubuntu}"
  instance_type       = "${var.instance_type_ubuntu}"
  min_size            = "${var.min_size_ubuntu}"
  max_size            = "${var.max_size_ubuntu}"
  desired_capacity    = "2"
  vpc_zone_identifier = ["${var.subnet}"]
  health_check_type   = "EC2"
}
module "debian" {
  name                = "debian"
  source              = "terraform-aws-modules/autoscaling/aws"
  lc_name             = "debian"
  image_id            = "${var.ami_debian}"
  instance_type       = "${var.instance_type_debian}"
  min_size            = "${var.min_size_debian}"
  max_size            = "${var.max_size_debian}"
  desired_capacity    = "2"
  vpc_zone_identifier = ["${var.subnet}"]
  health_check_type   = "EC2"
}

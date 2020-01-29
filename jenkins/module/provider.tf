provider "aws" {
  region = "${var.region}"
  version = "~> 2.46"
}
terraform {
  required_version = "0.11.14"
}

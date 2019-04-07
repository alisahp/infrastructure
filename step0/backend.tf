terraform {
  backend "s3" {
    bucket = "awx-terraform-bucket"
    region = "eu-west-1"
    key    = "terraform_key"
  }
}

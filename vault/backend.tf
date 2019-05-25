terraform {
  required_version = "0.12.0" 
  backend "s3" {
    bucket = "acirrustech-iaac"
    region = "us-east-1" 
    key    = "vault/infra"
  }
}

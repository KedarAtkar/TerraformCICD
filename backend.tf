terraform {
  backend "s3" {
    bucket = "mybucketak227"
    key    = "uat/terraform.tfstate"
    region = "ap-south-1"
  }
}
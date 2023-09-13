terraform {
  backend "s3" {
    bucket = "aziz-jenkins"
    key    = "terraform.tfstate"
    region = "us-east-2"
  }
}

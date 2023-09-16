provider "aws" {
region = var.region
}
resource "aws_instance" "web" {
ami = var.ami_name
instance_type = var.instance_type
availability_zone = var.az1
key_name = var.key_name
}

data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = [var.ami_name]
  }
  owners = ["self"]
}

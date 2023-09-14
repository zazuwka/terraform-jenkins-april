provider "aws" {
region = var.region
}
resource "aws_instance" "web" {
ami = var.ami_id
instance_type = var.instance_type
availability_zone = var.az1
key_name = var.key_name
}

provider "aws" {
region = "us-east-2"
}


resource "aws_instance" "web" {
ami = "ami-092b51d9008adea15"
instance_type = "t2.micro"
availability_zone = "us-east-2a"
key_name = "my-laptop-key"
}

provider "aws" {
  region     = "us-east-1"
}


resource "aws_vpc" "main" {
	cidr_block = "10.5.0.0/16"

	tags = var.vpc_tags
}

resource "aws_subnet" "main" {
	vpc_id     = aws_vpc.main.id
	cidr_block = "10.5.0.0/25"

	tags = {
		Name = "vpc-subnet"
	}
}

resource "aws_instance" "web-instance" {
  ami               = var.ami
  instance_type     = "t2.micro"
tags = {
  "Name" = "Ec2"
}

  }


provider "aws" {
  region     = "us-east-1"
  access_key = "key"
  secret_key = "key"
}


resource "aws_vpc" "first-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "firstVpc"
  }
}


resource "aws_subnet" "first-vpc-subnet" {
  vpc_id            = aws_vpc.first-vpc.id
  availability_zone = "us-east-1a"
  cidr_block        = "10.0.1.0/24"
  tags = {
    Name = "firstSubnet"
  }
}



resource "aws_instance" "first-instance" {
  ami           = "ami-0533f2ba8a1995cf9"
  instance_type = "t2.micro"
  tags = {
    Name = "FirstInstance"
  }
}

provider "aws" {
	region = "us-east-1"
}


provider "aws" {
    alias = "west"
    region = "us-west-1"
}


resource "aws_instance" "west-web" {
    provider = aws.west
	ami           = "ami-0a245a00f741d6301"
	instance_type = "t2.micro"

	tags = {
		Name = "Web Test west"
	}
}



resource "aws_instance" "east-web" {
	ami           = "ami-0533f2ba8a1995cf9"
	instance_type = "t2.micro"

	tags = {
		Name = "Web Test east"
	}
}


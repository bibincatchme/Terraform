provider "aws" {
	region = "us-east-1"
}


resource "aws_instance" "east-web" {
	ami           = "ami-0533f2ba8a1995cf9"
	instance_type = "t2.micro"
	
    lifecycle {
		create_before_destroy = true
		prevent_destroy       = true
		ignore_changes        = [tags]
	}

	tags = {
		Name = "Web Test"
	}
}


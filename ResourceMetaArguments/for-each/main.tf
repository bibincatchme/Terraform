provider "aws" {
	region = "us-east-1"
}


resource "aws_instance" "web" {
    for_each = {
        prod = "t2.medium"
        dev = "t2.micro"
}
	ami           = "ami-0533f2ba8a1995cf9"
	instance_type = each.value

	tags = {
		Name = "Web Test ${each.key}"
	}
}


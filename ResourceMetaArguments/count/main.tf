  
provider "aws" {
	region = "us-east-1"
}


resource "aws_instance" "web" {
	count         = 2
	ami           = "ami-0533f2ba8a1995cf9"
	instance_type = "t2.micro"

	tags = {
		Name = "Web Test ${count.index}"
	}
}

#List of instances IP address.......
output "instance_ip" {
  value = aws_instance.web[*].public_ip
}

#List using for loop
output "instance_ips" {
  value = [for instance in aws_instance.web : instance.public_ip]
}

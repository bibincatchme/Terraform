provider "aws" {
	region = "us-east-1"
}

resource "aws_instance" "web-instance" {
  ami = "ami-0742b4e673072066f"
  instance_type = "t2.micro"
  
  tags = {
      Name = "Webserver"
  }

#write the instance public ip address to a file in local machine  
provisioner "local-exec" {
    command = "echo ${self.public_ip} > public-ip.txt"
}  

}

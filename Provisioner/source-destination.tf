provider "aws" {
	region = "us-east-1"
}

resource "aws_instance" "web-instance" {
  ami = "ami-0742b4e673072066f"
  instance_type = "t2.micro"
  key_name = "terraform-key"
  
  tags = {
      Name = "Webserver"
  }

connection {
  type = "ssh"
  host = self.public_ip
  user = "ec2-user"
  private_key = file("/home/focus/Downloads/william.pem")
# Default timeout is 5 minutes
timeout     = "4m"
}

provisioner "file" {
    content = "Hello Webserver"
    destination  = "/home/ec2-user/ip.txt"
}  

}

output "ip" {
  value = aws_instance.web-instance.public_ip
}

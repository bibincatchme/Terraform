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

  #copy file from content/source to  destination
provisioner "file" {
    content = "Hello Webserver"
    destination  = "/home/ip.txt"
}  

}

output "ip" {
  value = aws_instance.web-instance.public_ip
}

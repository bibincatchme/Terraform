
provider "aws" {
  region     = var.region
}

locals {
  instance_name = "${terraform.workspace}-instance"
}


resource "aws_instance" "web-instance" {
  ami               = var.ami
  instance_type     = var.instance_type
  tags = {
      Name = local.instance_name
  }
}

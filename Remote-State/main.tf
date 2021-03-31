
terraform {
	backend "s3" {
		bucket = "bibin-terrafrom-state"
		key    = "remotestate/terraform.tfstate"
		region = "us-east-1"
	}
}


provider "aws" {
  region     = "us-east-1"
}


resource "aws_instance" "web-instance" {
  ami               = "ami-0742b4e673072066f"
  instance_type     = "t2.micro"
  tags = {
      Name = "Remote State"
  }
}




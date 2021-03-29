provider "aws" {
    region = "us-east-1"
  
}



data "aws_ami" "amazon_linux" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name = "name"

    values = [
      "amzn-ami-hvm-*-x86_64-gp2",
    ]
  }

  filter {
    name = "owner-alias"

    values = [
      "amazon",
    ]
  }
}


data "aws_vpc" "myvpc" {
    filter {
      name = "tag:Name"
      values = ["development-VPC"]
    }
  
}

output "vpcdetail" {
  value = data.aws_vpc.myvpc
}


resource "aws_subnet" "subnet_web" {
    vpc_id = data.aws_vpc.myvpc.id
    cidr_block = "192.168.2.0/24"
}

resource "aws_instance" "web" {
  ami = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"
  subnet_id = aws_subnet.subnet_web.id

}

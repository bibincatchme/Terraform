
provider "aws" {
  region     = "us-east-1"
  access_key = "AKIA2TUB4PVSQNSEH7MN"
  secret_key = "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"
}


# # 1. Create vpc
resource "aws_vpc" "prod-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "Production VPC"
  }
}


# # 2. Create Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.prod-vpc.id
}


# # 3. Create Custom Route Table
resource "aws_route_table" "prod-route-table" {
  vpc_id = aws_vpc.prod-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.gw.id
  }
  tags = {
    Name = "Prod"
  }
}

# # 4. Create a Subnet 
resource "aws_subnet" "prod-subnet1" {
  vpc_id            = aws_vpc.prod-vpc.id
  availability_zone = "us-east-1a"
  cidr_block        = "10.0.1.0/24"
  tags = {
    Name = "Production subnet1"
  }
}


# # 5. Associate subnet with Route Table
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.prod-subnet1.id
  route_table_id = aws_route_table.prod-route-table.id
}


# # 6. Create Security Group to allow port 22,80,443
resource "aws_security_group" "allow_web" {
  name        = "allow_web_traffic"
  description = "Allow WEB inbound traffic"
  vpc_id      = aws_vpc.prod-vpc.id

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" #any protocol
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_web"
  }
}


# # 7. Create a network interface with an ip in the subnet that was created in step 4

resource "aws_network_interface" "allow_webserver_nic" {
  subnet_id       = aws_subnet.prod-subnet1.id
  private_ips     = ["10.0.1.50"]
  security_groups = [aws_security_group.allow_web.id]
  # attachment {
  #   instance     = aws_instance.test.id
  #   device_index = 1
  # }
}


# # 8. Assign an elastic IP to the network interface created in step 7
resource "aws_eip" "one" {
  vpc                       = true
  network_interface         = aws_network_interface.allow_webserver_nic.id
  associate_with_private_ip = "10.0.1.50"
  depends_on                = [aws_internet_gateway.gw] # passing as a list, we have multiple we can spicy mutple things to specify
}




# # 9. Create Aamazon Ec2 server and install/enable apache

resource "aws_instance" "web-instance" {
  ami               = "ami-0533f2ba8a1995cf9"
  instance_type     = "t2.micro"
  availability_zone = "us-east-1a"
  key_name          = "terraform-key"
  network_interface {
    device_index         = 0
    network_interface_id = aws_network_interface.allow_webserver_nic.id
  }
  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install httpd -y
              sudo systemctl start httpd
              sudo bash -c 'echo your very first web server > /var/www/html/index.html'
              EOF

  tags = {
    Name = "WebInstance"
  }
}


# resource "<provider>_<resource_type>" "name" {
#     config options.....
#     key = "value"
#     key2 = "another value"
# }

# # Output results

output "server_private_ip" {
  value =  aws_instance.web-instance.private_ip
}

output "server_public_ip" {
  value = aws_instance.web-instance.public_ip
}

output "server_id" {
  value = aws_instance.web-instance.id
}





List of object from the file terraform.tfvars
subnet_prefix = [{cidr_block = "10.0.1.0/24", name = "prod_subnet"}, {cidr_block = "10.0.2.0/24", name = "dev_subnet"}]



Get the variables in main.tf by
resource "aws_subnet" "prod-subnet1" {
  vpc_id            = aws_vpc.prod-vpc.id
  availability_zone = "us-east-1a"
  cidr_block        = var.subnet_prefix[0].cidr_block # list of first array [0] call the cidr_block and name
  tags = {
    Name = var.subnet_prefix[0].name
  }
}

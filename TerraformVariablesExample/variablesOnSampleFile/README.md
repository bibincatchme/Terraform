Enter the value for subnet cidr, beacuse the variable value not defined, it will ask the value while run terraform apply command.


terraform apply
var.subnet_prefix
  cidr block for the subnet

##  Enter a value: 10.0.1.0/24


# pass the default variable 

variable "subnet_prefix" {
  description = "cidr block for the subnet"
  default = "10.0.66.0/24"
  #type = string |number |bool |list(<TYPE>) |set(<TYPE>) |map(<TYPE>) |object({<ATTR NAME> = <TYPE>, ... }) | tuple([<TYPE>, ...])
}





# Pass the variable though the command line

##terraform apply -var "subnet_prefix=10.0.100.0/24"

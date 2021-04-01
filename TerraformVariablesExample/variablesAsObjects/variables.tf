variable "ami" {
	type        = string
	description = "AMI for ec2"
}


variable "vpc_tags" {
    type = object({
        Name = string
        Version = number
    })
  
}


variable "instance_tags" {
	type = list(number)
	default = [1,2,3]
}

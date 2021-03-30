provider "aws" {
  region     = "us-east-1"
}

locals {
  baz = "hello"
}

resource "aws_instance" "example" {
  ami               = "ami-0533f2ba8a1995cf9"
  instance_type     = "t2.micro"

  tags = {
      Name = "Test ${local.baz}"

#check if yes or no    
     foo = local.baz == "aaa" ? "yes" : "no"
  
    bar = <<EOT
    testing foo
    EOT

#Using with aws userdata
    baz = <<-EOT
      hello from baz.....
    EOT
  
  testing_if = "Hello, %{ if var.name != "" }${var.name}%{ else }unnamed%{ endif}!"
  

# using loop list all the ips
    testing_loop = <<EOT
    %{ for ip in aws_instance.example.*.private_ip }
    server ${ip}
    %{endfor}
    EOT
  }

}

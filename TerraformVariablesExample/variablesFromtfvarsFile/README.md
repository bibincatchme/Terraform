Load the variable from terraform.tfvars file


subnet_prefix = "10.0.200.0/24"


#variables from a custom file.
example.tfvars
subnet_prefix = "10.0.200.0/24"



## terraform apply -var-file example.tfvars

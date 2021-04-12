#terraform


### How to turn on verbose logging in Terraform
TF_LOG=1

### How to refresh terraform tfstate
The terraform refresh command is used to reconcile the state Terraform knows about (via its state file) with the real-world infrastructure. This can be used to detect any drift from the last-known state, and to update the state file.
terraform refresh

### Terraform Destroy -- Create a plan with an outfile, then apply that planfile
  * terraform plan -destroy -out=DESTROYallTerraforms.tfplan 
  * terraform apply DESTROYallTerraforms.tfplan 


### Terraform output -- It will only apply
  *  terraform plan -out out.terrafrom | changed will saved to the out.terrafrom file
  *  terraform apply out.terrafrom | it will only apply the changed on the out.terrafrom file



By deafult the terraform variable type will be based on the value you assign to it

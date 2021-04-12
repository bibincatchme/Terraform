#terraform


### How to turn on verbose logging in Terraform
TF_LOG=1

### How to refresh terraform tfstate
The terraform refresh command is used to reconcile the state Terraform knows about (via its state file) with the real-world infrastructure. This can be used to detect any drift from the last-known state, and to update the state file.
terraform refresh

### Terraform Destroy -- Create a plan with an outfile, then apply that planfile
terraform plan -destroy -out=DESTROYallTerraforms.tfplan 
terraform apply DESTROYallTerraforms.tfplan 

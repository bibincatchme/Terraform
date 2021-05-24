```console
terraform init
terraform workspace new dev
terraform workspace new prod
terraform workspace show
terraform workspace list

  terraform workspace select dev
  terraform apply -var-file dev.tfvars
  terraform workspace select prod
  terraform apply -var-file prod.tfvars

  terraform workspace select prod
  terraform destroy -var-file prod.tfvars
```

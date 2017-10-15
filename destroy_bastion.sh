terraform init modules/ec2
terraform destroy -var-file="variables.tfvars" modules/ec2

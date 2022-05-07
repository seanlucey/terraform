module "createVPC" {
  
  source = "../../modules/vpc"
  
  name = "Test-VPC"
  cidr_block = "10.0.0.0/16"
}

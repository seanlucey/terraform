output "vpc_id" {
  description = "ID of VPC"
  value = module.vpc.vpc_id
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}

output "s3_endpoint_id" {
  value = module.vpc.s3_endpoint_id
}

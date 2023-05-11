data "aws_availability_zones" "azs" {}

locals {
    availability_zone  = slice(data.aws_availability_zones.azs.names, 0, 3)
    secondary_region = "us-west-1"
    destination_bucket_name = "replica-${var.bucket}-${var.environment}-${local.secondary_region}"
}

module "vpc" {
    source = "./modules/vpc"

    name = var.name
    cidr_block = var.cidr_block
    enable_dns_hostnames = var.enable_dns_hostnames
    enable_dns_support = var.enable_dns_support
    environment = var.environment
}
    
module "s3" {
    source = "./modules/s3"
    
    environment = var.environment
    bucket = var.bucket
    versioning = var.versioning
     
    replication_configuration = {
        rules = [
          {
           id = "crr-rule"
           status = true
           priority = 5
           delete_marker_replication = false
           destination = {
            bucket = "arn:aws:s3:::${local.destination_bucket_name}"
            replication_time = {
              status  = "Enabled"
              minutes = 15
             }
            metrics = {
              status  = "Enabled"
              minutes = 15
             }
            } 
          }
    ]}
}
    
module "replica_bucket" {
    source = "./modules/s3"
    
    providers = {
        aws = aws.secondary
    }
    
    environment = var.environment
    bucket = "replica-${var.bucket}"
    versioning = var.versioning
}

/*module "rds" {
   source = "./modules/rds"

    name = var.name
    environment = var.environment

    engine = var.engine
    engine_mode = var.engine_mode
    storage_encrypted = var.storage_encrypted

    allocated_storage = var.allocated_storage
    database_name = var.database_name

    db_cluster_instance_class = var.db_cluster_instance_class
    enable_global_write_forwarding = var.enable_global_write_forwarding

    engine_version = var.engine_version

    manage_master_user_password = var.manage_master_user_password
    master_user_secret_kms_key_id = var.master_user_secret_kms_key_id

    subnets = module.vpc.private_subnet_ids
    serverlessv2_scaling_configuration = var.serverlessv2_scaling_configuration
    vpc_security_group_ids = var.vpc_security_group_ids
    db_parameter_group_name = var.db_parameter_group_name
}*/

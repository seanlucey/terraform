name = "testing"
cidr_block = "10.10.0.0/16"
enable_dns_hostnames = "true"
enable_dns_support = "true"
environment = "dev"
s3_endpoint_enable = "true"

engine = "aurora-postgresql"
engine_mode = "provisioned"
storage_encrypted = "true"
database_name = "test database"
engine_version = "14.6"
manage_master_user_password = "true"
port = "5342"
serverlessv2_scaling_configuration = {
    min_capacity = 2
    max_capacity = 10
}

create_bucket = "true"
bucket = "foxitae466gge"
versioning = {
  status     = true
  mfa_delete = false
}

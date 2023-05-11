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

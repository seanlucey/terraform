resource "random_integer" "random" {
  min = 1
  max = 5000
}

resource "random_string" "random" {
  length  = 6
  special = false
  upper   = false
}

resource "aws_db_instance" "rds" {
  identifier                = var.instance_name-var.environment-random_integer.random.result
  
  engine                    = var.engine
  engine_version            = var.engine_version
  instance_class            = var.rds_instance_class
  allocated_storage         = var.rds_allocated_storage
  max_allocated_storage     = var.max_rds_allocated_storage
  kms_key_id                = var.kms_key_id
  license_model             = "license-included"
  
  username                  = var.username
  password                  = var.password
  port                      = var.port
  
  storage_type              = var.storage_type
  iops                      = var.iops
  multi_az                  = var.rds_multi_az

  
  allow_major_version_upgrade = var.allow_major_version_upgrade
  auto_minor_version_upgrade  = var.auto_minor_version_upgrade
  apply_immediately         = var.apply_immediately
  vpc_security_group_ids    = [aws_security_group.rds_security_group.id]
  db_subnet_group_name      = var.db_subnet_group_name
  availability_zone         = var.availability_zone
  
  deletion_protection       = true
  backup_retention_period   = var.backup_retention
  backup_window             = var.backup_window
  maintenance_window        = var.maintenance_window
  skip_final_snapshot       = var.skip_final_snapshot
  final_snapshot_identifier = local.final_snapshot_identifier
  publicly_accessible       = var.publicly_accessible  
  timezone                  = var.timezone
}

variable "database_name" {
    description = "(Optional, default 'null') Name of RDS Microsoft SQL database"
    type = string
    default = null
}
variable "rds_allocated_storage" {
    description = "(Required, default '100') The allocated storage in gibibytes. Minimum: 20 GiB. Maximum: 16,384 GiB."
    type = number
    default = "100"
}
variable "max_rds_allocated_storage" {
    description = "(Optional, default '100') Enables Storage Autoscaling with instances that support the feature. Must be greater than or equal to rds_allocated_storage or 0 to disable. Minimum: 20 GiB. Maximum: 16,384 GiB."
    type = number
    default = "100"
}
variable "storage_type" {
    description = "(Optional, default 'gp2') One of 'standard' (magnetic), 'gp2' (general purpose SSD), or 'io1' (provisioned IOPS SSD)."
    type = string
    default = "gp2"
}
variable "iops" {
    description = "(Optional, default '0') The amount of provisioned IOPS. Setting this implies a storage_type of 'io1'."
    type = number
    default = 0
}
variable "kms_key_id" {
    description = "(Optional, default 'null') The ARN for the KMS encryption key. If creating an encrypted replica, set this to the destination KMS ARN. If storage_encrypted is set to true and kms_key_id is not specified the default KMS key created in your account will be used."
    type = string
    default = null
}
variable "engine" {
    description = "(Required, default 'null') The database engine to use."
    type        = string
    default     = null
}
variable "engine_version" {
    description = "(Optional, default 'null') The engine version to use."
    type        = string
    default     = null
}
variable "rds_instance_class" {
    description = "(Required, default 'null') The instance type of the RDS instance."
    type = string
    default = null
}
variable "availability_zone" {
    description = "(Optional, default 'null') The AZ for the RDS instance."
    type = string
    default = null
}
variable "backup_retention" {
    description = "(Optional, default '0') The days to retain backups for. Must be between 0 and 35."
    type = number
    default = 0
}
variable "username" {
    description = "(Required, default 'admin') Username for the master DB user. Cannot be specified for a replica."
    type = string
    default = "admin"
    sensitive   = true
}
variable "password" {
    description = "(Required, default 'password') Password for the master DB user."
    type = string 
    default = "password"
    sensitive   = true
}
variable "port" {
    description = "(Optional, default '1433') The port on which the DB accepts connections."
    type = number
    default = "1433"
}
variable "rds_multi_az" {
    description = "(Optional, default 'false') Specifies if the RDS instance is multi-AZ."
    type = bool
    default = "false"
}
variable "apply_immediately" {
    description = "(Optional, default 'false') Specifies whether any database modifications are applied immediately, or during the next maintenance window."
    type = bool
    default = "false"
}
variable "allow_major_version_upgrade" {
    description = "(Optional, default 'false') Indicates that major version upgrades are allowed."
    type = bool
    default = "false"
}
variable "auto_minor_version_upgrade" {
    description = "(Optional, default 'true') Indicates that minor engine upgrades will be applied automatically to the DB instance during the maintenance window."
    type = bool
    default = "true"
}
variable "db_subnet_group_name" {
    description = "(Optional, default 'null') List of VPC security groups to associate."
    type = string
    default = null
}
variable "skip_final_snapshot" {
    description = "(Optional, default 'null') Name of DB subnet group."
    type = bool    
    default = null
}
variable "publicly_accessible" {
    description = "(Optional, default 'false') Bool to control if instance is publicly accessible."
    type = bool   
    default = "false"
}
variable "timezone" {
    description = "(Optional, default 'null') Time zone of the DB instance."
    type = string  
    default = null
}
variable "vpc_address" {
    description = "(Optional, default 'null') CIDR block of VPC."
    type = string   
    default = null
}
variable "vpc_id" {
    description = "(Optional, default 'null') List ID of associated VPC."
    type = string   
    default = null
}

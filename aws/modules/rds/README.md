## Variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_database_name"></a> [database\_name](#input\_database\_name) | (Optional, default 'null') Name of RDS Microsoft SQL database | `string` | n/a | no |
| <a name="input_rds_allocated_storage"></a> [rds\_allocated\_storage](#input\_rds\_allocated\_storage) | (Required, default '100') The allocated storage in gibibytes. Minimum: 20 GiB. Maximum: 16,384 GiB | `number` | `100` | yes |
| <a name="input_max_rds_allocated_storage"></a> [max\_rds\_allocated\_storage](#input\_max\_rds\_allocated\_storage) | (Optional, default '100') Enables Storage Autoscaling with instances that support the feature. Must be greater than or equal to rds_allocated_storage or 0 to disable. Minimum: 20 GiB. Maximum: 16,384 GiB | `number` | `100` | no |
| <a name="input_storage_type"></a> [storage\_type](#input\_storage\_type) | (Optional, default 'gp2') One of "standard" (magnetic), "gp2" (general purpose SSD), or "io1" (provisioned IOPS SSD) | `string` | `gp2` | no |
| <a name="input_ios"></a> [iops](#input\_iops) | (Optional, default '0') The amount of provisioned IOPS. Setting this implies a storage_type of "io1" | `number` | `0` | no |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | (Optional, default 'null') The ARN for the KMS encryption key. If creating an encrypted replica, set this to the destination KMS ARN. If storage_encrypted is set to true and kms_key_id is not specified the default KMS key created in your account will be used | `string` | n/a | no |
| <a name="input_engine"></a> [engine](#input\_engine) | (Required, default 'null') The database engine to use | `string` | n/a | yes |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | (Optional, default 'null') The engine version to use | `string` | n/a | no |
| <a name="input_rds_instance_class"></a> [rds\_instance\_class](#input\_rds\_instance\_class) | (Required, default 'null') The instance type of the RDS instance | `string` | n/a | yes |
| <a name="input_availability_zone"></a> [availability\_zone](#input\_availability\_zone) | (Optional, default 'null') The AZ for the RDS instance | `string` | n/a | no |
| <a name="input_backup_retention"></a> [backup\_retention](#input\_backup\_retention) | (Optional, default '0') The days to retain backups for. Must be between 0 and 35 | `string` | `0` | no |
| <a name="input_username"></a> [username](#input\_username) | (Required, default 'admin') Username for the master DB user. Cannot be specified for a replica. | `string` | `admin` | yes |
| <a name="input_password"></a> [password](#input\_password) | (Required, default 'password') Password for the master DB user | `string` | `password` | yes |
| <a name="input_port"></a> [port](#input\_port) | (Optional default '1433') The port on which the DB accepts connections. | `number` | `1433` | no |
| <a name="input_rds_multi_az"></a> [rds\_multi\_az](#input\_rds\_multi\_az) | (Optional, default 'false') Specifies if the RDS instance is multi-AZ | `bool` | `false` | no |
| <a name="input_allow_major_version_upgrade"></a> [allow\_major\_version\_upgrade](#input\_allow\_major\_version\_upgrade) | (Optional, default 'false') Indicates that major version upgrades are allowed. | `bool` | `false` | no |
| <a name="input_auto_minor_version_upgrade"></a> [auto\_minor\_version\_upgrade](#input\_auto\_minor\_version\_upgrade) | (Optional, default 'true') Indicates that minor engine upgrades will be applied automatically to the DB instance during the maintenance window. | `bool` | `true` | no |
| <a name="input_apply_immediately"></a> [apply\_immediately](#input\_apply\_immediately) | (Optional, default 'false') Specifies whether any database modifications are applied immediately, or during the next maintenance window. | `bool` | `false` | no |
| <a name="input_vpc_security_group_ids"></a> [vpc\_security\_group\_ids](#input\_vpc\_security\_group\_ids) | (Optional, default 'null') List of VPC security groups to associate. | `string` | n/a | no |
| <a name="input_db_subnet_group_name"></a> [db\_subnet\_group\_name](#input\_db\_subnet\_group\_name) | (Optional, default 'null') Name of DB subnet group. | `string` | n/a | no |
| <a name="input_skip_final_snapshot"></a> [skip\_final\_snapshot](#input\_skip\_final\_snapshot) | (Optional, default 'false') Determines whether a final DB snapshot is created before the DB instance is deleted | `bool` | `false` | no |
| <a name="input_publicly_accessible"></a> [publicly\_accessible](#input\_publicly\_accessible) | (Optional, default 'false') Bool to control if instance is publicly accessible | `bool` | `false` | no |
| <a name="input_timezone"></a> [timezone](#input\_timezone) | (Optional, default 'null') Time zone of the DB instance. | `string` | n/a | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | (Optional, default 'null') List ID of associated VPC. | `string` | n/a | no |



## Outputs

| Name | Description |
|------|-------------|

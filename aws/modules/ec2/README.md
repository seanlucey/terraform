## Variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | (Optional, default 'null') Name to be used on EC2 instance created. | `string` | n/a | no |
| <a name="input_ami"></a> [ami](#input\_ami) | (Optional, default 'null') ID of AMI to use for the instance. | `string` | n/a | no |
| <a name="input_associate_public_ip_address"></a> [associate\_public\_ip\_address](#input\_associate\_public\_ip\_address) | (Optional, default 'null') Whether to associate a public IP address with an instance in a VPC. | `bool` | n/a | no |
| <a name="input_availability_zone"></a> [availability\_zone](#input\_availability\_zone) | (Optional, default 'null') AZ to start the instance in. | `string` | n/a | no |
| <a name="input_capacity_reservation_specification"></a> [capacity\_reservation\_specification](#input\_capacity\_reservation\_specification) | (Optional, default 'null') Describes an instance's Capacity Reservation targeting option. | `any` | n/a | no |
| <a name="input_customer"></a> [customer](#input\_customer) | (Optional, default 'null') Describes what customer environment is associated with. | `string` | n/a | no |
| <a name="input_ebs_block_device"></a> [ebs\_block\_device](#input\_ebs\_block\_device) | (Optional, default 'empty') Additional EBS block devices to attach to the instance. | `map` | `null` | no |
| <a name="input_enclave_options_enabled"></a> [enclave\_options\_enabled](#input\_enclave\_options\_enabled) | (Optional, default 'false') Whether Nitro Enclaves will be enabled on the instance. | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | (Optional, default 'uat') Specific whether build is for Production or Staging environment. | `string` | 'uat' | no |
| <a name="input_ephemeral_block_device"></a> [ephemeral\_block\_device](#input\_ephemeral\_block\_device) | (Optional, default 'empty') Customize Ephemeral (also known as Instance Store) volumes on the instance. | `list` | `null` | no |
| <a name="input_get_password_data"></a> [get_password_data](#input\_get\_password\_data) | (Optional, default 'null') If true, wait for password data to become available and retrieve it. | `bool` | n/a | no |
| <a name="input_host_id"></a> [host\_id](#input\_host\_id) | (Optional, default 'null') ID of a dedicated host that the instance will be assigned to. Use when an instance is to be launched on a specific dedicated host. | `string` | n/a | no |
| <a name="input_iam_instance_profile"></a> [iam\_instance\_profile](#input\_iam\_instance\_profile) | (Optional, default 'null') IAM Instance Profile to launch the instance with. Specified as the name of the Instance Profile. | `string` | n/a | no |
| <a name="input_instance_associate_public_ip"></a> [instance\_associate\_public\_ip](#input\_instance\_associate\_public\_ip) | (Optional, default 'false') Optional) Whether to associate a public IP address with an instance in a VPC. | `bool` | `false` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | (Optional, default 't3.micro') The type of instance to start. | `string` | `t3.micro` | no |
| <a name="input_internal"></a> [internal](#input\_internal) | (Optional, default 'true') If true, the LB will be internal. | `bool` | `true` | no |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | (Optional, default 'null') Key name of the Key Pair to use for the instance; which can be managed using the `aws_key_pair` resource. | `string` | n/a | no |
| <a name="input_launch_template"></a> [launch\_template](#input\_launch\_template) | (Optional, default 'null') Specifies a Launch Template to configure the instance. Parameters configured on this resource will override the corresponding parameters in the Launch Template. | `map` | n/a | no |
| <a name="input_load_balancer_type"></a> [load\_balancer\_type](#input\_load\_balancer\_type) | (Optional, default 'application') The type of load balancer to create. | `string` | `application` | no |
| <a name="input_metadata_options"></a> [metadata\_options](#input\_metadata\_options) | (Optional, default 'empty') Customize the metadata options of the instance. | `map` | `null` | no |
| <a name="input_monitoring"></a> [monitoring](#input\_monitoring) | (Optional, default 'false') If true, the launched EC2 instance will have detailed monitoring enabled | `bool` | `false` | no |
| <a name="input_network_interface"></a> [network\_interface](#input\_network\_interface) | (Optional, default 'empty') Customize network interfaces to be attached at instance boot time | `map` | `null` | no |
| <a name="input_root_block_device"></a> [root\_block\_device](#input\_root\_block\_device) | (Optional, default 'empty') Customize details about the root block device of the instance. See Block Devices below for details | `any` | n/a | no |
| <a name="input_security_groups"></a> [security_groups](#input\_security\_groups) | (Optional, default 'null') A list of security group IDs to assign to the LB. | `string` | n/a | no |
| <a name="input_source_dest_check"></a> [source\_dest\_check](#input\_source\_dest\_check) | (Optional, default 'null') ID of AMI to use for the instance. | `bool` | `true` | no |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | (Optional, default 'null') A list of subnet IDs to attach to the LB. | `string` | n/a | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_ami) | (Optional, default 'null') The VPC Subnet ID to launch in. | `string` | n/a | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional, default 'empty') A mapping of tags to assign to the resource" | `string` | `null` | no |
| <a name="input_tenancy"></a> [tenancy](#input\_tenancy) | (Optional, default 'null') The tenancy of the instance (if the instance is running in a VPC). Available values: default, dedicated, host. | `string` | n/a | no |
| <a name="input_volume_tags"></a> [volume\_tags](#input\_volume\_tags) | (Optional, default 'empty') A mapping of tags to assign to the devices created by the instance at launch time. | `map` | `null` | no |
| <a name="input_enable\_volume\_tags"></a> [enable_volume_tags](#input\_enable\_volume\_tags) | (Optional, default 'true') Whether to enable volume tags (if enabled it conflicts with root_block_device tags). | `bool` | `true` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | (Optional, default 'null') List ID of associated VPC. | `string` | n/a | no |
| <a name="input_vpc_security_group_ids"></a> [vpc\_security\_group\_ids](#input\_vpc\_security\_group\_ids) | (Optional, default 'null') A list of security group IDs to associate with. | `string` | n/a | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | (Optional, default 'empty') Define maximum timeout for creating, updating, and deleting EC2 instance resources | `map` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | n/a |
| <a name="output_arn"></a> [arn](#output\_arn) | n/a |
| <a name="output_instance_state"></a> [instance\_state](#output\_instance\_state) | n/a |
| <a name="output_password_data"></a> [password\_data](#output\_password\_data) | n/a |
| <a name="output_primary_network_interface_id"></a> [primary\_network\_interface\_id](#output\_primary\_network\_interface\_id) | n/a |
| <a name="output_private_ip"></a> [private\_ip](#output\_private\_ip) | n/a |

variable "name" {
  description = "(Optional, default 'null') Name to be used on EC2 instance created."
  type        = string
  default     = ""
}
variable "ami" {
  description = "(Optional, default 'null') ID of AMI to use for the instance."
  type        = string
  default     = ""
}
variable "associate_public_ip_address" {
  description = "(Optional, default 'null') Whether to associate a public IP address with an instance in a VPC."
  type        = bool
  default     = null
}
variable "availability_zone" {
  description = "(Optional, default 'null') AZ to start the instance in."
  type        = string
  default     = null
}
variable "capacity_reservation_specification" {
  description = "(Optional, default 'null') Describes an instance's Capacity Reservation targeting option."
  type        = any
  default     = null
}
variable "customer" {
    description = "(Optional, default 'null') Describes what customer environment is associated with."
    type = string   
    default = null
}
variable "ebs_block_device" {
  description = "(Optional, default 'empty') Additional EBS block devices to attach to the instance."
  type        = list(map(string))
  default     = []
}
variable "ebs_optimized" {
  description = "(Optional, default 'null') If true, the launched EC2 instance will be EBS-optimized."
  type        = bool
  default     = null
}
variable "enclave_options_enabled" {
  description = "(Optional, default 'false') Whether Nitro Enclaves will be enabled on the instance."
  type        = bool
  default     = "false"
}
variable "environment" {
    description = "(Optional, default 'uat') Specific whether build is for Production or Staging environment."
    type = string   
    default = "uat"
}
variable "ephemeral_block_device" {
  description = "(Optional, default 'empty') Customize Ephemeral (also known as Instance Store) volumes on the instance."
  type        = list(map(string))
  default     = []
}
variable "get_password_data" {
  description = "(Optional, default 'null') If true, wait for password data to become available and retrieve it."
  type        = bool
  default     = null
}
variable "host_id" {
  description = "(Optional, default 'null') ID of a dedicated host that the instance will be assigned to. Use when an instance is to be launched on a specific dedicated host."
  type        = string
  default     = null
}
variable "iam_instance_profile" {
  description = "(Optional, default 'null') IAM Instance Profile to launch the instance with. Specified as the name of the Instance Profile."
  type        = string
  default     = null
}
variable "instance_associate_public_ip" {
  description = "(Optional, default 'false') Optional) Whether to associate a public IP address with an instance in a VPC."
  type        = bool
  default     = "false"
}
variable "instance_type" {
  description = "(Optional, default 't3.micro') The type of instance to start."
  type        = string
  default     = "t3.micro"
}
variable "internal" {
  description = "(Optional, default 'true') If true, the LB will be internal."
  type        = bool
  default     = "true"
}
variable "key_name" {
  description = "(Optional, default 'null') Key name of the Key Pair to use for the instance; which can be managed using the `aws_key_pair` resource."
  type        = string
  default     = null
}
variable "launch_template" {
  description = "(Optional, default 'null') Specifies a Launch Template to configure the instance. Parameters configured on this resource will override the corresponding parameters in the Launch Template."
  type        = map(string)
  default     = null
}
variable "load_balancer_type" {
  description = "(Optional, default 'application') The type of load balancer to create."
  type        = string
  default     = "application"
}
variable "metadata_options" {
  description = "(Optional, default 'empty') Customize the metadata options of the instance."
  type        = map(string)
  default     = {}
}
variable "monitoring" {
  description = "(Optional, default 'false') If true, the launched EC2 instance will have detailed monitoring enabled"
  type        = bool
  default     = false
}
variable "network_interface" {
  description = "(Optional, default 'empty') Customize network interfaces to be attached at instance boot time"
  type        = list(map(string))
  default     = []
}

variable "root_block_device" {
  description = "(Optional, default 'empty') Customize details about the root block device of the instance. See Block Devices below for details"
  type        = list(any)
  default     = []
}
variable "security_groups" {
  description = "(Optional, default 'null') A list of security group IDs to assign to the LB."
  type        = list(string)
  default     = null
}
variable "source_dest_check" {
  description = "(Optional, default 'true') Controls if traffic is routed to the instance when the destination address does not match the instance. Used for NAT or VPNs."
  type        = bool
  default     = true
}
variable "subnets" {
  description = "(Optional, default 'null') A list of subnet IDs to attach to the LB."
  type        = list(string)
  default     = null
}
variable "subnet_id" {
  description = "(Optional, default 'null') The VPC Subnet ID to launch in."
  type        = string
  default     = null
}
variable "tags" {
  description = "(Optional, default 'empty') A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}
variable "tenancy" {
  description = "(Optional, default 'null') The tenancy of the instance (if the instance is running in a VPC). Available values: default, dedicated, host."
  type        = string
  default     = null
}
variable "volume_tags" {
  description = "(Optional, default 'empty') A mapping of tags to assign to the devices created by the instance at launch time."
  type        = map(string)
  default     = {}
}
variable "enable_volume_tags" {
  description = "(Optional, default 'true') Whether to enable volume tags (if enabled it conflicts with root_block_device tags)."
  type        = bool
  default     = true
}
variable "vpc_id" {
    description = "(Optional, default 'null') List ID of associated VPC."
    type = string   
    default = null
}
variable "vpc_security_group_ids" {
  description = "(Optional, default 'null') A list of security group IDs to associate with."
  type        = list(string)
  default     = null
}
variable "timeouts" {
  description = "(Optional, default 'empty') Define maximum timeout for creating, updating, and deleting EC2 instance resources"
  type        = map(string)
  default     = {}
}

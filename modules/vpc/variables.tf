variable "AWS_REGION" {
    description = "The region where to deploy this code. Defaults EU-West-1."
    default = "eu-west-1"
}
variable "vpc_cidr_block" {
  description = "(Required) The CIDR block for the VPC."
  default     = ""
}
variable "vpc_enable_dns_hostnames" {
  description = "(Optional) A boolean flag to enable/disable DNS hostnames in the VPC. Defaults false."
  default     = false
}
variable "vpc_name" {
  description = "Name to be used on VPC resource"
  default     = "TEST"
}

variable "AWS_REGION" {
    default = "eu-west-1"
}
variable "cidr_block" {
    type = string
}
variable "vpc_enable_dns_hostnames" {
  description = "(Optional) A boolean flag to enable/disable DNS hostnames in the VPC. Defaults false."
  default     = false
}

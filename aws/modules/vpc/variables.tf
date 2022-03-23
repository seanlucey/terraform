variable "AWS_REGION" {
    description = "(Optional, default 'eu-west-1') The region where to deploy this code."
    default = "eu-west-1"
}
variable "name" {
  description = "(Required) The name of the vpc"
  type        = string
}
variable "cidr_block" {
  description = "(Optional) The IPv4 CIDR block for the VPC."
  type        = string
}

variable "cidr_block" {
  description = "(Required) The CIDR block for the VPC."
  type = string
}

variable "enable_dns_hostnames" {
  description = "(Optional) A boolean flag to enable/disable DNS hostnames in the VPC."
  type = bool
}

variable "enable_dns_support" {
  description = "(Optional) A boolean flag to enable/disable DNS support in the VPC."
  type = bool
}

variable "environment" {
  description = "(Optional) Determines environment flag to be used."
  type = string
}

variable "name" {
  description = "Name to be used on all resources as prefix"
  type = string
}

variable "s3_endpoint_enable" {
  description = "(Optional) Determines whether or not an S3 Endpoint will be created."
  type = bool
}


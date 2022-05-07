variable "vault_token" {
  description = "(Required, default 'null') Vault token to use for authentication."
  type        = string
  default     = null
}

variable "vault_addr" {
  description = "(Required, default 'null') Vault address."
  type        = string
  default     = null
}

variable "vault_token" {
  description = "(Required, default 'null') Vault token to use for authentication."
  type        = string
  default     = null
}

variable "vault_addr" {
  description = "(Required, default 'https://vault.genesisahc.com') Vault address."
  type        = string
  default     = "https://localhost:8200"
}

variable "mssql_path" {
  description = "(Required, default 'mssql') Where the secret backend will be mounted."
  type        = string
  default     = "mssql"
}

variable "mssql_default_lease" {
  description = "(Optional, default '3600') Default lease duration for tokens and secrets in seconds."
  type        = number
  default     = 3600
}

variable "mssql_max_lease" {
  description = "(Optional, default '3600') Maximum lease for Database secrets engine for mssql."
  type        = number
  default     = 3600
}

variable "mssql_seal_wrapping" {
  description = "(Optional, default 'true') Enable seal wrapping for the DB secrets engine for mssql."
  type        = bool
  default     = true
}

variable "mssql_local_mount" {
  description = "(Optional, default 'true') Boolean flag that can be explicitly set to true to enforce local mount in HA environment"
  type        = bool
  default     = true
}

variable "mssql_external_entropy_access" {
  description = "(Optional, default 'true') Boolean flag that can be explicitly set to true to enable the secrets engine to access Vault's external entropy source"
  type        = bool
  default     = true
}

variable "mssql_allowed_roles" {
  description = "(Required, default 'null') A list of roles that are allowed to use this connection."
  type        = list(string)
  default     = null

}

variable "mssql_root_rotation_statements" {
  description = "(Optional, default 'null') A list of database statements to be executed to rotate the root user's credentials."
  type        = list(string)
  default     = null
}

variable "mssql_verify_connection" {
  description = "(Required, default 'false') Whether the connection should be verified on initial configuration or not."
  type        = bool
  default     = false
}

variable "mssql_connection_url" {
  description = "(Required, default 'sqlserver://admin:myPassword@localhost:1433') A URL containing connection information."
  type        = string
  default     = "sqlserver://admin:myPassword@localhost:1433"
}

variable "mssql_max_connection_lifetime" {
  description = "(Optional, default '360') The maximum number of seconds to keep a connection alive for."
  type        = number
  default     = 360
}

variable "mssql_max_idle_connections" {
  description = "(Optional, default '360') The maximum number of idle connections to maintain."
  type        = number
  default     = 360
}

variable "mssql_max_open_connections" {
  description = "(Optional, default '360') The maximum number of open connections to use."
  type        = number
  default     = 360
}


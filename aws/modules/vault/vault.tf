resource "vault_mount" "mssql" {
  count = contains(var.databases, "mssql") ? 1 : 0
  path = var.mssql_path
  type = "database"

  default_lease_ttl_seconds = var.mssql_default_lease
  max_lease_ttl_seconds = var.mssql_max_lease
  
  seal_wrap               = var.mssql_seal_wrapping
  local                   = var.mssql_local_mount
  external_entropy_access = var.mssql_external_entropy_access

  description = "The database secrets engine for mssql is mounted at the ${element(var.secrets_engines, count.index)}/ path"
}

resource "vault_database_secret_backend_connection" "mssql" {
        count = contains{var.databases, "mssql") ? 1 : 0
        backend = vault_mount.mssql[count.index].path

        name = var.mssql_path
        allowed_roles = var.mssql_allowed_roles

        mssql {
                connection_url = var.mssql_connection_url
                max_connection_lifetime = var.mssql_max_connection_lifetime
                max_idle_connections = var.mssql_max_idle_connections
                max_open_connections = var.mssql_max_open_connections
                }
        data = {
                addr = var.vault_addr
                toke = var.vault_token
                }
}

resource "vault_database_secret_backend_role" "role" {
        for_each = {
                for role in var.db_roles :
                role.name => role
        }

        backend = each.value["backend"]
        name = each.value["name"]
        db_name = each.value["db_name"]

        creation_statements = each.value["creation_statements"]

        default_ttl = each.value["dafault_ttl"]
        max_ttl = each.value["default_ttl"]

        depends_on = [
                vault_mount.mssql,
                vault_database_secret_backend_connection.mssql
        ]

}


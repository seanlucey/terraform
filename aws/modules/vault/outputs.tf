output "mssql_mount_accessor" {
  value = vault_mount.mssql[*].accessor
}

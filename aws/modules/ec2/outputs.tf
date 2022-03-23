output "id" {
  description = "The ID of the instance"
  value       = try(aws_instance.ec2.id, "")
}
output "arn" {
  description = "The ARN of the instance"
  value       = try(aws_instance.ec2.arn, "")
}
output "instance_state" {
  description = "The state of the instance. One of: `pending`, `running`, `shutting-down`, `terminated`, `stopping`, `stopped`"
  value       = try(aws_instance.ec2.instance_state, "")
}
output "password_data" {
  description = "Base-64 encoded encrypted password data for the instance. Useful for getting the administrator password for instances running Microsoft Windows. This attribute is only exported if `get_password_data` is true"
  value       = try(aws_instance.ec2.password_data, "")
}
output "primary_network_interface_id" {
  description = "The ID of the instance's primary network interface"
  value       = try(aws_instance.ec2.primary_network_interface_id, "")
}
output "private_ip" {
  description = "The private IP address assigned to the instance."
  value       = try(aws_instance.ec2.private_ip, "")
}

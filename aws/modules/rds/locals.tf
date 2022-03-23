locals {
  
final_snapshot_identifier = var.skip_final_snapshot ? null : "${var.skip_final_snapshot}-${var.instance_name}-${var.environment}-${random_integer.snapshot.result}"

}

resource "random_integer" "snapshot" {
  min = 1
  max = 50000
}

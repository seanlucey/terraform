resource "aws_s3_bucket" "s3_bucket" {
  count = local.create_bucket ? 1 : 0

  bucket = var.bucket
  force_destroy = var.force_destroy

  tags = merge(local.common_tags, {
    Name = "${var.bucket}.${var.environment}.${element(local.zone_names, count.index)}"
  })
}

resource "aws_s3_bucket_versioning" "s3_bucket_versioning" {
  count = local.create_bucket && length(keys(var.versioning)) > 0 ? 1 : 0

  bucket = aws_s3_bucket.s3_bucket[0].id
  mfa = try(var.versioning["mfa"], null)

  versioning_configuration {
    status = try(var.versioning["enabled"] ? "Enabled" : "Suspended", tobool(var.versioning["status"]) ? "Enabled" : "Suspended", title(lower(var.versioning["status"])))

    mfa_delete = try(tobool(var.versioning["mfa_delete"]) ? "Enabled" : "Disabled", title(lower(var.versioning["mfa_delete"])), null)
  }
}
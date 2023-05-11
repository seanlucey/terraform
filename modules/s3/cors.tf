resource "aws_s3_bucket_cors_configuration" "s3_bucket_cors" {
  count = length(local.cors_rules) > 0 ? 1 : 0

  bucket = aws_s3_bucket.s3_bucket.id

  dynamic "cors_rule" {
    for_each = local.cors_rules

    content {
      id              = try(cors_rule.value.id, null)
      allowed_methods = cors_rule.value.allowed_methods
      allowed_origins = cors_rule.value.allowed_origins
      allowed_headers = try(cors_rule.value.allowed_headers, null)
      expose_headers  = try(cors_rule.value.expose_headers, null)
      max_age_seconds = try(cors_rule.value.max_age_seconds, null)
    }
  }
}

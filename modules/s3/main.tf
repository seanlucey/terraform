resource "aws_s3_bucket" "s3_bucket" {
  bucket = "${var.bucket}-${var.environment}-${local.aws_region}"
  force_destroy = var.force_destroy

  tags = merge(local.common_tags, {
    Name = "${var.bucket}-${var.environment}-${local.aws_region}"
  })
}

resource "aws_s3_bucket_versioning" "s3_bucket_versioning" {
  bucket = aws_s3_bucket.s3_bucket.id

  versioning_configuration {
    status = try(var.versioning["enabled"] ? "Enabled" : "Suspended")
  }
}

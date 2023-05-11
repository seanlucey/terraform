resource "aws_s3_bucket" "s3_bucket" {
  bucket = "${lower(var.bucket)}-${lower(var.environment)}-${local.aws_region}"
  force_destroy = var.force_destroy

  tags = merge(local.common_tags, {
    Name = "${var.bucket}-${var.environment}-${local.aws_region}"
  })
}

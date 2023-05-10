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
    status = try(var.versioning["enabled"] ? "Enabled" : "Suspended", tobool(var.versioning["status"]) ? "Enabled" : "Suspended", title(lower(var.versioning["status"])))
  }
}

resource "aws_s3_bucket_replication_configuration" "s3_bucket_crr" {
  count = local.create_crr_bucket ? 1 : 0
  
  bucket = aws_s3_bucket.s3_bucket.id
  role = var.replication_configuration
  
  dynamic "destination" {
    content {
      bucket = destination.value.bucket
    }
/*     access_control_translation {
        owner = "Destination"
      }
    
    dynamic "encryption_configuration" {
     content {
              replica_kms_key_id = encryption_configuration.value
            }
          }*/

  depends_on = [aws_s3_bucket_versioning.s3_bucket_versioning]  
}

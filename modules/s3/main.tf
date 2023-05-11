resource "aws_s3_bucket" "s3_bucket" {
  bucket = "lower(${var.bucket}-${var.environment}-${local.aws_region})"
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
  count = length(keys(var.replication_configuration)) > 0 ? 1 : 0
  
  bucket = aws_s3_bucket.s3_bucket.id
  role = aws_iam_role.replication.arn
  
  dynamic "rule" {
    for_each = flatten(try([var.replication_configuration["rule"]], [var.replication_configuration["rules"]], []))
    
    content {
      status   = try(tobool(rule.value.status) ? "Enabled" : "Disabled", title(lower(rule.value.status)), "Enabled")

      dynamic "destination" {
       for_each = try(flatten([rule.value.destination]), [])
       
       content {   
        bucket = destination.value.bucket
       }
        
      }
     }
     dynamic "replication_time" {
      for_each = try(flatten([destination.value.replication_time]), [])

      content {
        status = try(tobool(replication_time.value.status) ? "Enabled" : "Disabled", title(lower(replication_time.value.status)), "Disabled")

        dynamic "time" {
          for_each = try(flatten([replication_time.value.minutes]), [])

          content {
            minutes = replication_time.value.minutes
          }
        }
      }
    }
   }

  depends_on = [aws_s3_bucket_versioning.s3_bucket_versioning]  
}

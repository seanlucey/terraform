resource "aws_s3_bucket_replication_configuration" "s3_bucket_crr" {
  count = length(keys(var.replication_configuration)) > 0 ? 1 : 0

  bucket = aws_s3_bucket.s3_bucket.id
  role = aws_iam_role.replication.arn

  dynamic "rule" {
    for_each = flatten(try([var.replication_configuration["rule"]], [var.replication_configuration["rules"]], []))
    content {
      id       = try(rule.value.id, null)
      priority = try(rule.value.priority, null)
      status   = try(tobool(rule.value.status) ? "Enabled" : "Disabled", title(lower(rule.value.status)), "Enabled")

      dynamic "destination" {
        for_each = try(flatten([rule.value.destination]), [])
        content {
          bucket = destination.value.bucket

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

          dynamic "metrics" {
            for_each = try(flatten([destination.value.metrics]), [])
            content {
              status = try(tobool(metrics.value.status) ? "Enabled" : "Disabled", title(lower(metrics.value.status)), "Disabled")

              dynamic "event_threshold" {
                for_each = try(flatten([metrics.value.minutes]), [])
                content {
                  minutes = metrics.value.minutes
                }
              }
            }
          }
        }
      }
      
    dynamic "filter" {
     for_each = length(try(flatten([rule.value.filter]), [])) == 0 ? [true] : []
      content {
       }
     }
   }
  }
  depends_on = [aws_s3_bucket_versioning.s3_bucket_versioning]
}

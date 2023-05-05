output "s3_bucket_id" {
  description = "The name of the bucket."
  value       = try(aws_s3_bucket.s3_bucket[0].id, "")
}

output "s3_bucket_region" {
  description = "The AWS region this bucket resides in."
  value       = try(aws_s3_bucket.s3_bucket[0].region, "")
}
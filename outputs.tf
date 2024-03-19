output "s3_bucket_name" {
  value = aws_s3_bucket.oci_logs_bucket.bucket
}

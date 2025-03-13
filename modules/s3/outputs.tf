#aws_s3_bucket
output "bucket_domain_name" {
  value = aws_s3_bucket.this[0].bucket_regional_domain_name
}

output "bucket_domain_name_0" {
  value = aws_s3_bucket.this[0].bucket_domain_name
}

output "bucket_arn" {
  value = aws_s3_bucket.this[0].arn
}

output "bucket_id" {
  value = aws_s3_bucket.this[0].id
}

output "access_block_id" {
  value = aws_s3_bucket_public_access_block.this.*.id
}

output "ownership_control_id" {
  value = aws_s3_bucket_ownership_controls.this.*.id
}

output "acl_id" {
  value = aws_s3_bucket_acl.this.*.id
}

output "versioning_id" {
  value = aws_s3_bucket_versioning.this.*.id
}

output "acceleration_id" {
  value = aws_s3_bucket_accelerate_configuration.this.*.id
}

output "log_conf_id" {
  value = aws_s3_bucket_object_lock_configuration.this.*.id
}

output "payer_conf_id" {
  value = aws_s3_bucket_request_payment_configuration.this.*.id
}

output "website_conf_id" {
  value = aws_s3_bucket_website_configuration.this.*.id
}

output "website_domain" {
  value = aws_s3_bucket_website_configuration.this.*.website_domain
}

output "website_endpoint" {
  value = aws_s3_bucket_website_configuration.this.*.website_endpoint
}

output "object_arn" {
  value = aws_s3_object.this.*.arn
}


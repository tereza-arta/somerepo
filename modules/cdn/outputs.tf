output "cf_oac_id" {
  value = aws_cloudfront_origin_access_control.this.*.id
}

output "cf_oac_arn" {
  value = aws_cloudfront_origin_access_control.this.*.arn
}

output "cf_domain_name" {
  value = aws_cloudfront_distribution.this[0].domain_name
}

output "cf_id" {
  value = aws_cloudfront_distribution.this[0].id
}

output "cf_arn" {
  value = aws_cloudfront_distribution.this[0].arn
}

output "cf_status" {
  value = aws_cloudfront_distribution.this[0].status
}

output "cf_last_modification" {
  value = aws_cloudfront_distribution.this[0].last_modified_time
}

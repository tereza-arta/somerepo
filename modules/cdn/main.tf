resource "aws_cloudfront_origin_access_control" "this" {
  name = var.cf_name
  origin_access_control_origin_type = var.cf_origin
  signing_behavior = var.sign_behavior
  signing_protocol = "sigv4"
  description = var.oac_desc
}

resource "aws_cloudfront_distribution" "this" {
  enabled = var.enabled
  is_ipv6_enabled = var.ipv6_enabled
  comment = var.comment
  default_root_object = var.def_root_obj
  #price_class = var.price_class
  #aliases = var.aliases

  origin {
    domain_name = var.bucket_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.this.id
    origin_id = var.origin_id
  }

  default_cache_behavior {
    allowed_methods = var.cache_allowed_methods
    cached_methods = var.cached_methods
    target_origin_id = var.origin_id

    viewer_protocol_policy = var.viewer_proto_policy
    min_ttl = var.min_ttl
    max_ttl = var.max_ttl
    default_ttl = var.default_ttl

   forwarded_values {
    query_string = var.query_string
    cookies {
      forward = var.cookie_forward
    }
  }  

  }

  restrictions {
    geo_restriction {
      restriction_type = var.restriction_type
      #locations = var.loactions
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = var.cf_def_cert
  }

}

data "aws_iam_policy_document" "s3_bucket_policy" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${var.bucket_arn}/*"]
    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }
    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"
      values   = [aws_cloudfront_distribution.this.arn]
    }
  }
}

resource "aws_s3_bucket_policy" "static_site_bucket_policy" {
  bucket = var.origin_id
  policy = data.aws_iam_policy_document.s3_bucket_policy.json
}

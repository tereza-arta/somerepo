resource "aws_cloudfront_origin_access_control" "this" {
  count                             = var.cf_oac_cnt
  name                              = var.cf_name
  origin_access_control_origin_type = var.cf_origin
  signing_behavior                  = var.sign_behavior
  signing_protocol                  = "sigv4"
  description                       = var.oac_desc
}

resource "aws_cloudfront_distribution" "this" {
  count               = var.cf_distribution_cnt
  enabled             = var.enabled
  is_ipv6_enabled     = var.ipv6_enabled
  comment             = var.comment
  default_root_object = var.def_root_obj

  origin {
    domain_name              = var.bucket_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.this[count.index].id
    origin_id                = var.origin_id
  }

  default_cache_behavior {
    allowed_methods  = var.cache_allowed_methods
    cached_methods   = var.cached_methods
    target_origin_id = var.origin_id

    viewer_protocol_policy = var.viewer_proto_policy
    min_ttl                = var.min_ttl
    max_ttl                = var.max_ttl
    default_ttl            = var.default_ttl

    #Instead use for.ex. cache_policy_id
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

#data "aws_iam_policy_document" "s3_bucket_policy" {
#  count = var.policy_doc_cnt
#  statement {
#    actions   = var.policy_action
#    resources = ["${var.bucket_arn}/*"]
#    principals {
#      type        = var.principal_type
#      identifiers = var.principals
#    }
#    condition {
#      test     = var.condition_name
#      variable = var.condition_var
#      values   = [aws_cloudfront_distribution.this[count.index].arn]
#    }
#  }
#}

#resource "aws_s3_bucket_policy" "static_site_bucket_policy" {
#  count  = var.policy_cnt
#  bucket = var.origin_id
#  policy = data.aws_iam_policy_document.s3_bucket_policy[count.index].json
#}

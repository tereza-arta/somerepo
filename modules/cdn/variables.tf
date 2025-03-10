variable "cf_name" {
  default = "With S3"
}

variable "cf_origin" {
  default = "s3"
}

variable "sign_behavior" {
  default = "always"
}

variable "oac_desc" {
  default = "Some OAC desc"
}

variable "enabled" {
  type    = bool
  default = true
}

variable "ipv6_enabled" {
  type    = bool
  default = false
}

variable "comment" {
  default = "Some-dist-comment"
}

variable "def_root_obj" {
  default = "index.html"
}

variable "viewer_proto_policy" {
  default = "allow-all"
}

variable "min_ttl" {
  type    = number
  default = 0
}

variable "max_ttl" {
  type    = number
  default = 86400
}

variable "default_ttl" {
  type    = number
  default = 3600
}

variable "query_string" {
  type    = bool
  default = false
}

variable "cookie_forward" {
  default = "none"
}

variable "compress" {
  type    = bool
  default = false
}

variable "price_class" {
  default = "PriceClass_All"
}

variable "aliases" {
  type    = list(string)
  default = ["cf.example.com"]
}

variable "bucket_domain_name" {}

variable "origin_id" {}

variable "cache_allowed_methods" {
  type    = list(string)
  default = ["GET", "HEAD"]
}

variable "cached_methods" {
  type    = list(string)
  default = ["GET", "HEAD"]
}

variable "restriction_type" {
  default = "none"
}

variable "loactions" {
  type    = list(string)
  default = ["US", "EU"]
}

variable "cf_def_cert" {
  type    = bool
  default = true
}

variable "bucket_arn" {}


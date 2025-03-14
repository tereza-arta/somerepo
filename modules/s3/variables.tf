variable "bucket_cnt" {
  type    = number
  default = 1
}

variable "bucket_name" {
  default = "test-bucket-745"
}

variable "bucket_prefix" {
  default = "unique-prefix"
}

variable "destroy" {
  type        = bool
  default     = true
  description = "In bucket destroy time destroy bucket objects also or not"
}

variable "object_lock" {
  type    = bool
  default = false
}

variable "bucket_tag" {
  default = "Bucket-tag"
}

variable "access_definition_cnt" {
  type    = number
  default = 1
}

variable "block_public_acls" {
  type    = bool
  default = true
}

variable "block_public_policy" {
  type    = bool
  default = true
}

variable "ignore_public_acls" {
  type    = bool
  default = true
}

variable "restrict_public_buckets" {
  type    = bool
  default = true
}

variable "ownership_definiton_cnt" {
  type    = number
  default = 1
}

variable "obj_ownership" {
  default = "BucketOwnerPreferred"
}

variable "object_cnt" {
  type    = number
  default = 1
}

variable "object_name" {
  default = "index.html"
}

variable "obj_rel_path" {
  default = "objects/index.html"
}

variable "content_type" {
  default = "text/html"
}

variable "storage_class" {
  default = "STANDARD"
}

variable "object_tag" {
  default = "Object-tag-value"
}

#variable "policy_action" {
#  type = list(string)
#  default = ["s3:GetObject"]
#}
#
#variable "policy_resource" {
#  type = list(string)
#  default = ["${var.bucket_arn}/*"]
#}
#
#variable "principal_type" {
#  default = "Service"
#}
#
#variable "principals" {
#  type = list(string)
#  default = ["cloudfront.amazonaws.com"]
#}

variable "acl_cnt" {
  type    = number
  default = 1
}

variable "acl" {
  default = "private"
}

variable "expected_owner_id" {
  default = "637423489195"
}

variable "policy_cnt" {
  type    = number
  default = 1
}

#Missing
variable "s3_bucket_policy" {}

#variable "origin_id" {}

variable "tf_data_for_index" {
  type    = bool
  default = true
}

#Missing
variable "backend_endpoint" {}

variable "versioning_res_cnt" {
  type    = number
  default = 0
}

variable "versioning" {
  default = "Enabled"
}

variable "mfa_delete" {
  default = "Disabled"
}

variable "acceleration_res_cnt" {
  type    = number
  default = 0
}

variable "acceleration_status" {
  default = "Suspended"
}

variable "lock_res_cnt" {
  type    = number
  default = 0
}

variable "lock_bucket_index" {
  type    = number
  default = 0
}

variable "lock_retention_mode" {
  default = "GOVERNANCE"
}

variable "lock_retention_days" {
  type    = number
  default = 0
}

variable "payment_conf_cnt" {
  type    = number
  default = 0
}

variable "payer" {
  default = "Requester"
}

variable "website_conf_cnt" {
  type    = number
  default = 0
}

variable "index_doc" {
  default = "index.html"
}

variable "error_doc" {
  default = ""
}


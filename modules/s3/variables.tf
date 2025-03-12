variable "bucket_name" {
  default = "test-bucket-745"
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

variable "obj_ownership" {
  default = "BucketOwnerPreferred"
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

variable "acl" {
  default = "private"
}

variable "tf_data_for_index" {
  type = bool
  default = true
}

#Missing
variable "backend_endpoint" {}

variable "versioning" {
  default = "Enabled"
}

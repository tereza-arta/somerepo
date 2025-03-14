locals {
  ob_name_split    = split(".", var.obj_rel_path)
  content_type_key = local.ob_name_split[1]
  content_type = {
    html = "text/html"
    css  = "text/css"
    jpeg = "image/jpeg"
    jpg  = "image/jpeg"
    json = "application/json"
    mp4  = "video/mp4"
    png  = "image/png"
    pdf  = "application/pdf"
    xls  = "application/vnd.ms-excel"
  }
}

resource "aws_s3_bucket" "this" {
  count         = var.bucket_cnt
  bucket        = var.bucket_name
  force_destroy = var.destroy
  #bucket_prefix = var.bucket_prefix
  #object_lock_enabled = var.object_lock
  #acl = var.acl

  tags = {
    Name = var.bucket_tag
  }
}

resource "aws_s3_bucket_public_access_block" "this" {
  count  = var.access_definition_cnt
  bucket = aws_s3_bucket.this[count.index].id

  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  ignore_public_acls      = var.ignore_public_acls
  restrict_public_buckets = var.restrict_public_buckets
}

resource "aws_s3_bucket_ownership_controls" "this" {
  count  = var.ownership_definiton_cnt
  bucket = aws_s3_bucket.this[count.index].id
  rule {
    object_ownership = var.obj_ownership
  }
}

resource "aws_s3_bucket_acl" "this" {
  count                 = var.acl_cnt
  bucket                = aws_s3_bucket.this[count.index].id
  acl                   = var.acl
  expected_bucket_owner = var.expected_owner_id

  depends_on = [aws_s3_bucket_ownership_controls.this]
}

resource "aws_s3_bucket_versioning" "this" {
  count  = var.versioning_res_cnt
  bucket = aws_s3_bucket.this[count.index].id
  versioning_configuration {
    status     = var.versioning
    mfa_delete = var.mfa_delete
  }
}

resource "aws_s3_bucket_accelerate_configuration" "this" {
  count  = var.acceleration_res_cnt
  bucket = aws_s3_bucket.this[count.index].id
  status = var.acceleration_status
}

resource "aws_s3_bucket_object_lock_configuration" "this" {
  count  = var.lock_res_cnt
  bucket = aws_s3_bucket.this[var.lock_bucket_index].id

  rule {
    default_retention {
      mode = var.lock_retention_mode
      days = var.lock_retention_days
      #years
    }
  }
}

resource "aws_s3_bucket_request_payment_configuration" "this" {
  count  = var.payment_conf_cnt
  bucket = aws_s3_bucket.this[count.index].id
  payer  = var.payer
}

resource "aws_s3_bucket_website_configuration" "this" {
  count  = var.website_conf_cnt
  bucket = aws_s3_bucket.this[count.index].id

  index_document {
    suffix = var.index_doc
  }

  error_document {
    key = var.error_doc
  }
}

resource "aws_s3_object" "this" {
  count  = var.object_cnt
  bucket = aws_s3_bucket.this[count.index].id
  key    = var.object_name
  source = "${path.module}/${var.obj_rel_path}"
  #content_type  = var.content_type
  content_type  = lookup(local.content_type, local.content_type_key)
  storage_class = var.storage_class
  #acl = var.acl

  tags = {
    Name = var.object_tag
  }

  depends_on = [terraform_data.for_index_file[0]]
}

resource "terraform_data" "for_index_file" {
  count = var.tf_data_for_index ? 1 : 0
  provisioner "local-exec" {
    command = <<EOF
    sed -E -i'' "s%(.*baseUrl = ).*%\1'${var.backend_endpoint}info';%" '${path.module}/${var.obj_rel_path}'
    EOF
  }
  triggers_replace = {
    "run_at" = timestamp()
  }
}

resource "aws_s3_bucket_policy" "static_site_bucket_policy" {
  count  = var.policy_cnt
  bucket = aws_s3_bucket.this[0].id
  policy = var.s3_bucket_policy
}


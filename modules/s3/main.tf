resource "aws_s3_bucket" "this" {
  bucket        = var.bucket_name
  force_destroy = var.destroy
  #object_lock_enabled = var.object_lock

  tags = {
    Name = var.bucket_tag
  }
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id

  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  ignore_public_acls      = var.ignore_public_acls
  restrict_public_buckets = var.restrict_public_buckets
}

resource "aws_s3_bucket_ownership_controls" "this" {
  bucket = aws_s3_bucket.this.id
  rule {
    object_ownership = var.obj_ownership
  }
}

resource "aws_s3_bucket_acl" "this" {
  bucket = aws_s3_bucket.this.id
  acl    = var.acl

  depends_on = [aws_s3_bucket_ownership_controls.this]
}

resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id
  versioning_configuration {
    status = var.versioning
  }
}

resource "aws_s3_object" "this" {
  bucket       = aws_s3_bucket.this.id
  key          = var.object_name
  #source       = "${path.module}/objects/index.html"
  source       = "${path.module}/${var.obj_rel_path}"
  content_type = var.content_type
  #acl = var.acl

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

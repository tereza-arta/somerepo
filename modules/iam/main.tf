data "aws_iam_policy_document" "this" {
  count = var.policy_document_cnt
  statement {
    effect = var.policy_effect

    principals {
      type        = var.principal
      identifiers = var.identifiers
    }

    actions = var.actions
  }
}

#S3 bucket policy
data "aws_iam_policy_document" "with_cond" {
  count = var.policy_doc_with_cond_cnt
  statement {
    actions   = var.policy_action
    resources = ["${var.bucket_arn}/*"]
    principals {
      type        = var.principal_type
      identifiers = var.principals
    }
    condition {
      test     = var.condition_name
      variable = var.condition_var
      values   = [var.cdn_arn]
    }
  }
}

#For lambda itself
resource "aws_iam_role" "this" {
  count              = var.role_cnt
  name               = var.lambda_role_name
  assume_role_policy = data.aws_iam_policy_document.this[count.index].json
}

#For access to CloudWatch
resource "aws_iam_policy" "this" {
  count = var.policy_cnt
  name  = var.policy_name
  policy = jsonencode({
    Version = var.role_policy_version
    Statement = [
      {
        Effect   = var.role_policy_2_effect
        Action   = var.role_policy_2_action
        Resource = var.role_policy_2_resource
      }
    ]
  })
}

#For logging
resource "aws_iam_role_policy_attachment" "this" {
  count      = var.role_policy_attach_cnt
  role       = aws_iam_role.this[count.index].id
  policy_arn = aws_iam_policy.this[count.index].arn
}

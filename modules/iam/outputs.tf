output "policy_doc_json" {
  value = data.aws_iam_policy_document.this[0].json
}

output "policy_doc_min_json" {
  value = data.aws_iam_policy_document.this[0].minified_json
}

output "policy_doc_with_cond_json" {
  value = data.aws_iam_policy_document.with_cond[0].json
}

output "policy_doc_with_cond_min_json" {
  value = data.aws_iam_policy_document.with_cond[0].minified_json
}

output "role_arn" {
  value = aws_iam_role.this[0].arn
}

output "role_id" {
  value = aws_iam_role.this[0].id
}

output "role_create_date" {
  value = aws_iam_role.this[0].create_date
}

output "role_name" {
  value = aws_iam_role.this[0].name
}

output "role_unique_id" {
  value = aws_iam_role.this[0].unique_id
}

output "policy_arn" {
  value = aws_iam_policy.this[0].arn
}

output "policy_id" {
  value = aws_iam_policy.this[0].id
}

output "policy_attachment_count" {
  value = aws_iam_policy.this[0].attachment_count
}

output "attachment_role" {
  value = aws_iam_role_policy_attachment.this[0].role
}

output "attachment_policy_arn" {
  value = aws_iam_role_policy_attachment.this[0].policy_arn
}

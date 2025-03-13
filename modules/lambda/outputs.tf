output "func_name" {
  value = aws_lambda_function.for_api[0].function_name
}

output "invoke_arn" {
  value = aws_lambda_function.for_api[0].invoke_arn
}

output "policy_doc_json" {
  value = aws_iam_policy_document.this.*.json
}

output "policy_doc_min_json" {
  value = aws_iam_policy_document.this.*.minified_json
}

output "role_id" {
  value = aws_iam_role.for_lambda.*.id
}

output "role_arn" {
  value = aws_iam_role.for_lambda.*.arn
}

output "role_name" {
  value = aws_iam_role.for_lambda.*.name
}

output "role_unique_id" {
  value = aws_iam_role.for_lambda.*.unique_id
}

output "policy_id" {
  value = aws_iam_policy.access_to_clodwatch.*.id
}

output "policy_arn" {
  value = aws_iam_policy.access_to_clodwatch.*.arn
}

output "policy_name" {
  value = aws_iam_policy.access_to_clodwatch.*.name
}

output "cloudwatch_log_group_arn" {
  value = aws_cloudwatch_log_group.for_lambda.*.arn
}

output "lambda_arn" {
  value = aws_lambda_function.for_api.*.id
}

output "lambda_last_modification" {
  value = aws_lambda_function.for_api.*.last_modified
}

output "lambda_source_code_size" {
  value = aws_lambda_function.for_api.*.source_code_size
}

output "alias_arn" {
  value = aws_lambda_alias.this.*.arn
}

output "alias_invoke_arn" {
  value = aws_lambda_alias.this.*.invoke_arn
}


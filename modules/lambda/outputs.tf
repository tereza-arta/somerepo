output "func_name" {
  value = aws_lambda_function.for_api[0].function_name
}

output "invoke_arn" {
  value = aws_lambda_function.for_api[0].invoke_arn
}

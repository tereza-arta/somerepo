output "func_name" {
  value = aws_lambda_function.for_api.function_name
}

output "invoke_arn" {
  value = aws_lambda_function.for_api.invoke_arn
}

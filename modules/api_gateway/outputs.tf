output "invoke_url" {
  value = aws_apigatewayv2_stage.test[0].invoke_url
}

output "execution_arn" {
  value = aws_apigatewayv2_api.this[0].execution_arn
}

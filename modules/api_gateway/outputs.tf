output "invoke_url" {
  value = aws_apigatewayv2_stage.test.invoke_url
}

output "execution_arn" {
  value = aws_apigatewayv2_api.this[count.index].execution_arn
}

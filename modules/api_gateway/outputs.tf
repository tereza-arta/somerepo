output "invoke_url" {
  value = aws_apigatewayv2_stage.test[0].invoke_url
}

output "execution_arn" {
  value = aws_apigatewayv2_api.this[0].execution_arn
}

output "api_id" {
  value = aws_apigatewayv2_api.this.*.id
}

output "api_arn" {
  value = aws_apigatewayv2_api.this.*.arn
}

output "api_endpoint" {
  value = aws_apigatewayv2_api.this.*.api_endpoint
}

output "log_group_arn" {
  value = aws_cloudwatch_log_group.this.*.arn
}

output "deployment_id" {
  value = aws_apigatewayv2_deployment.this.*.id
}

output "stage_id" {
  value = aws_apigatewayv2_stage.test.*.id
}

output "stage_arn" {
  value = aws_apigatewayv2_stage.test.*.arn
}

output "integration_id" {
  value = aws_apigatewayv2_integration.lambda.*.id
}

output "route_id" {
  value = aws_apigatewayv2_route.proxy.*.id
}

output "acm_cert_id" {
  value = aws_acm_certificate.this.*.id
}

output "acm_cert_arn" {
  value = aws_acm_certificate.this.*.arn
}

output "acm_cert_domain_name" {
  value = aws_acm_certificate.this.*.domain_name
}

output "acm_cert_status" {
  value = aws_acm_certificate.this.*.status
}

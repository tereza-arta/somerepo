#HTTP API configuration
resource "aws_apigatewayv2_api" "this" {
  count         = var.api_cnt
  name          = var.api_gw_name
  protocol_type = var.api_gw_proto

  cors_configuration {
    allow_origins     = var.allow_origins
    allow_methods     = var.allow_methods
    allow_headers     = var.allow_headers
    expose_headers    = var.expose_headers
    max_age           = var.max_age
    allow_credentials = var.allow_credentials
  }
}

resource "aws_cloudwatch_log_group" "this" {
  count = var.api_log_group_cnt
  name  = var.log_group_name

  retention_in_days = var.log_retention_days
}

resource "aws_apigatewayv2_deployment" "this" {
  count       = var.deployment_cnt
  api_id      = aws_apigatewayv2_api.this[count.index].id
  description = var.deploy_desc

  triggers = {
    redeployment = sha1(join(",", tolist([
      jsonencode(aws_apigatewayv2_integration.lambda[count.index]),
      jsonencode(aws_apigatewayv2_route.proxy[count.index]),
    ])))
  }
  #  lifecycle {
  #    create_before_destroy = true
  #  }
}

resource "aws_apigatewayv2_stage" "test" {
  count  = var.api_stage_cnt
  api_id = aws_apigatewayv2_api.this[count.index].id

  name          = var.stage_name
  auto_deploy   = var.stage_auto_deploy
  deployment_id = var.deployment_cnt != 0 ? aws_apigatewayv2_deployment.this[count.index].id : null

  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.this[count.index].arn

    format = jsonencode({
      requestId               = "$context.requestId"
      sourceIp                = "$context.identity.sourceIp"
      requestTime             = "$context.requestTime"
      protocol                = "$context.protocol"
      httpMethod              = "$context.httpMethod"
      resourcePath            = "$context.resourcePath"
      routeKey                = "$context.routeKey"
      status                  = "$context.status"
      responseLength          = "$context.responseLength"
      integrationErrorMessage = "$context.integrationErrorMessage"
      }
    )
  }
}

resource "aws_apigatewayv2_integration" "lambda" {
  count            = var.integration_cnt
  api_id           = aws_apigatewayv2_api.this[count.index].id
  integration_type = var.integration_type
  integration_uri  = var.target_uri
}

resource "aws_apigatewayv2_route" "proxy" {
  count     = var.route_cnt
  api_id    = aws_apigatewayv2_api.this[count.index].id
  route_key = var.route_key
  target    = "integrations/${aws_apigatewayv2_integration.lambda[count.index].id}"
}

resource "aws_lambda_permission" "api_gw" {
  count         = var.lambda_perm_cnt
  statement_id  = var.perm_statement_id
  action        = var.perm_action
  function_name = var.lambda_func_name
  principal     = var.principal

  source_arn = "${aws_apigatewayv2_api.this[count.index].execution_arn}/*/*"
}

#Certificate/domain configuration
#>>>>>
resource "aws_acm_certificate" "this" {
  count       = var.aws_cert_cnt
  domain_name = var.domain_name
}

#???
resource "aws_apigatewayv2_domain_name" "this" {
  count       = var.gw_domain_name_cnt
  domain_name = var.domain_name

  domain_name_configuration {
    certificate_arn = aws_acm_certificate.this[count.index].arn
    endpoint_type   = "REGIONAL"
    security_policy = "TLS_1_2"
  }
}

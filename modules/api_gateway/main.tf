resource "aws_apigatewayv2_api" "this" {
  name          = var.api_gw_name
  protocol_type = var.api_gw_proto

  cors_configuration {
    allow_origins = var.allow_origins
    allow_methods = var.allow_methods
    allow_headers = var.allow_headers
    expose_headers = var.expose_headers
    max_age = var.max_age
    allow_credentials = var.allow_credentials
  }
}

resource "aws_cloudwatch_log_group" "this" {
  name = var.log_group_name

  retention_in_days = var.log_retention_days
}

resource "aws_apigatewayv2_stage" "test" {
  api_id = aws_apigatewayv2_api.this.id

  name        = var.stage_name
  auto_deploy = var.stage_auto_deploy

  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.this.arn

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
  api_id           = aws_apigatewayv2_api.this.id
  integration_type = var.integration_type
  integration_uri  = var.target_uri
}

resource "aws_apigatewayv2_route" "proxy" {
  api_id    = aws_apigatewayv2_api.this.id
  route_key = var.route_key
  target    = "integrations/${aws_apigatewayv2_integration.lambda.id}"
}

resource "aws_lambda_permission" "api_gw" {
  statement_id  = var.perm_statement_id
  action        = var.perm_action
  function_name = var.lambda_func_name
  principal     = var.principal

  source_arn = "${aws_apigatewayv2_api.this.execution_arn}/*/*"
}


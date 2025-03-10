variable "api_gw_name" {
  default = "testApiGW"
}

variable "api_gw_proto" {
  default = "HTTP"
}

variable "log_group_name" {
  default = "for-api-gw-access-logs"
}

variable "log_retention_days" {
  type    = number
  default = 30
}

variable "stage_name" {
  default = "$default"
}

variable "stage_auto_deploy" {
  type    = bool
  default = true
}

variable "integration_type" {
  default = "AWS_PROXY"
}

#Missing
variable "target_uri" {}

variable "route_key" {
  default = "ANY /{proxy+}"
}

variable "perm_statement_id" {
  default = "LambdaPermForAPIGateway"
}

variable "perm_action" {
  default = "lambda:InvokeFunction"
}

#Missing
variable "lambda_func_name" {}

variable "principal" {
  default = "apigateway.amazonaws.com"
}


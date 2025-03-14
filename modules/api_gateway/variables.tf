variable "api_cnt" {
  type    = number
  default = 1
}

variable "api_gw_name" {
  default = "testApiGW"
}

variable "api_gw_proto" {
  default = "HTTP"
}

#Missing
#variable "allow_origins" {}

variable "allow_origins" {
  type    = list(string)
  default = ["*"]
}

variable "allow_methods" {
  type    = list(string)
  default = ["*"]
}

variable "allow_headers" {
  type    = list(string)
  default = ["*"]
}

variable "expose_headers" {
  type    = list(string)
  default = ["*"]
}

variable "max_age" {
  type    = number
  default = 0
}

variable "allow_credentials" {
  type    = bool
  default = false
}

variable "api_log_group_cnt" {
  type    = number
  default = 1
}

variable "log_group_name" {
  default = "for-api-gw-access-logs"
}

variable "deployment_cnt" {
  type    = number
  default = 0
}

variable "deploy_desc" {
  default = "Some-deploy-desc"
}

variable "log_retention_days" {
  type    = number
  default = 30
}

variable "api_stage_cnt" {
  type    = number
  default = 1
}

variable "stage_name" {
  default = "$default"
}

variable "stage_auto_deploy" {
  type    = bool
  default = true
}

variable "integration_cnt" {
  type    = number
  default = 1
}

variable "integration_type" {
  default = "AWS_PROXY"
}

#Missing
variable "target_uri" {}

variable "route_cnt" {
  type    = number
  default = 1
}

variable "route_key" {
  default = "ANY /{proxy+}"
}

#variable "lambda_perm_cnt" {
#  type    = number
#  default = 1
#}
#
#variable "perm_statement_id" {
#  default = "LambdaPermForAPIGateway"
#}
#
#variable "perm_action" {
#  default = "lambda:InvokeFunction"
#}
#
##Missing
#variable "lambda_func_name" {}
#
#variable "principal" {
#  default = "apigateway.amazonaws.com"
#}

variable "aws_cert_cnt" {
  type    = number
  default = 0
}

variable "domain_name" {
  default = "somedomain.com"
}

variable "gw_domain_name_cnt" {
  type    = number
  default = 0
}

variable "endpoint_type" {
  default = "REGIONAL"
}

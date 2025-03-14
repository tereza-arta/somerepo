variable "policy_document_cnt" {
  type    = number
  default = 1
}

variable "policy_effect" {
  default = "Allow"
}

variable "principal" {
  default = "Service"
}

variable "identifiers" {
  type    = list(string)
  default = ["lambda.amazonaws.com"]
}

variable "actions" {
  type    = list(string)
  default = ["sts:AssumeRole"]
}

variable "role_cnt" {
  type    = number
  default = 1
}

variable "lambda_role_name" {
  default = "LambdaPrimaryRole"
}

variable "role_policy_version" {
  default = "2012-10-17"
}

variable "role_policy_2_effect" {
  default = "Allow"
}

variable "role_policy_2_action" {
  type = list(string)
  default = [
    "logs:CreateLogGroup",
    "logs:CreateLogStream",
    "logs:PutLogEvents",
    "logs:DescribeLogStreams"
  ]
}

variable "role_policy_2_resource" {
  type    = list(string)
  default = ["arn:aws:logs:us-east-1:637423489195:*:*"]
}

variable "role_policy_attach_cnt" {
  type    = number
  default = 1
}

variable "policy_cnt" {
  type    = number
  default = 1
}

variable "policy_name" {
  default = "LambdaAccessToCloudWatch"
}

variable "log_group_cnt" {
  type    = number
  default = 1
}

variable "log_group_name" {
  default = "ForLambdaLogging"
}

variable "retention_days" {
  type    = number
  default = 1
}

variable "archive_file_cnt" {
  type    = number
  default = 1
}

variable "archive_type" {
  default = "zip"
}

variable "source_dir" {
  default = "source_code"
}

variable "lambda_func_cnt" {
  type    = number
  default = 1
}

variable "dest_path" {
  default = "source_code.zip"
}

variable "func_name" {
  default = "apiFunc"
}

variable "lambda_role" {}

variable "handler" {
  default = "index.handler"
}

variable "lambda_runtime" {
  default = "nodejs22.x"
}

variable "log_format" {
  default = "Text"
}

variable "alias_cnt" {
  type    = number
  default = 0
}

variable "alias_name" {
  default = "lambda-alias"
}

variable "func_version" {
  default = "1"
}

variable "recursion_cnt" {
  type    = number
  default = 0
}

variable "recursive_loop" {
  default = "Allow"
}

variable "lambda_perm_cnt" {
  type    = number
  default = 1
}

variable "perm_statement_id" {
  default = "LambdaPermForAPIGateway"
}

variable "perm_action" {
  default = "lambda:InvokeFunction"
}

variable "perm_principal" {
  default = "apigateway.amazonaws.com"
}

#Missing
variable "exec_arn" {}

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

variable "lambda_role_name" {
  default = "LambdaPrimaryRole"
}

variable "second_role_name" {
  default = "LambdaSecondRole"
}

variable "role_policy_version" {
  default = "2012-10-17"
}

variable "role_policy_effect" {
  default = "Allow"
}

variable "role_policy_principal" {
  default = "lambda.amazonaws.com"
}

variable "role_name" {
  default = "ForFuncLoogging"
}

variable "policy_action" {
  type = list(string)
  default = ["logs:CreateLogStream", "logs:PutLogEvents"]
}

variable "sec_policy_effect" {
  default = "Allow"
}

variable "policy_resource" {
  default = "arn:aws:logs:*:*:*"
}

variable "log_group_name" {
  default = "ForLambdaLogging"
}

variable "retention_days" {
  type = number
  default = 1
}

#variable "prevent_destroy" {
#  type = bool
#  default = false
#}

variable "archive_type" {
  default = "zip"
}

variable "source_dir" {
  default = "source_code"
}

variable "dest_path" {
  default = "source_code.zip"
}

variable "func_name" {
  default = "apiFunc"
}

variable "handler" {
  default = "index.handler"
}

variable "lambda_runtime" {
  default = "nodejs22.x"
}


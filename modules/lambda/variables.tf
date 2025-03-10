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
  default = "for_lambda"
}

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



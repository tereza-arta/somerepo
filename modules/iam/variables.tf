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

variable "policy_doc_with_cond_cnt" {
  type    = number
  default = 1
}

variable "policy_action" {
  type    = list(string)
  default = ["s3:GetObject"]
}

#Missing
variable "bucket_arn" {}

variable "principal_type" {
  default = "Service"
}

variable "principals" {
  type    = list(string)
  default = ["cloudfront.amazonaws.com"]
}

variable "condition_name" {
  default = "StringEquals"
}

variable "condition_var" {
  default = "AWS:SourceArn"
}

#Missing
variable "cdn_arn" {}

variable "role_cnt" {
  type    = number
  default = 1
}

variable "lambda_role_name" {
  default = "LambdaPrimaryRole"
}

variable "policy_cnt" {
  type    = number
  default = 1
}

variable "policy_name" {
  default = "LambdaAccessToCloudWatch"
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

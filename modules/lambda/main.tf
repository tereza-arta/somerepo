#>>>>>
#Policy/role for Lambda itself
data "aws_iam_policy_document" "this" {
  count = var.policy_document_cnt
  statement {
    effect = var.policy_effect

    principals {
      type        = var.principal
      identifiers = var.identifiers
    }

    actions = var.actions
  }
}

resource "aws_iam_role" "for_lambda" {
  count              = var.role_cnt
  name               = var.lambda_role_name
  assume_role_policy = data.aws_iam_policy_document.this[count.index].json
}


#Problem
#>>>>>
#Policy for Lambda access to CloudWatch
resource "aws_iam_policy" "access_to_clodwatch" {
  count = var.policy_cnt
  name  = var.policy_name
  policy = jsonencode({
    Version = var.role_policy_version
    Statement = [
      {
        Effect   = var.role_policy_2_effect
        Action   = var.role_policy_2_action
        Resource = var.role_policy_2_resource
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "for_logging" {
  count      = var.role_policy_attach_cnt
  role       = aws_iam_role.for_lambda[count.index].id
  policy_arn = aws_iam_policy.access_to_clodwatch[count.index].arn
}

resource "aws_cloudwatch_log_group" "for_lambda" {
  count             = var.log_group_cnt
  name              = var.log_group_name
  retention_in_days = var.retention_days
}

data "archive_file" "for_lambda" {
  count       = var.archive_file_cnt
  type        = var.archive_type
  source_dir  = "${path.module}/${var.source_dir}"
  output_path = "${path.module}/${var.dest_path}"
}

resource "aws_lambda_function" "for_api" {
  count         = var.lambda_func_cnt
  filename      = "${path.module}/${var.dest_path}"
  function_name = var.func_name
  role          = aws_iam_role.for_lambda[count.index].arn
  handler       = var.handler
  runtime       = var.lambda_runtime

  logging_config {
    log_format = var.log_format
    log_group  = aws_cloudwatch_log_group.for_lambda[count.index].name
  }

  depends_on = [aws_cloudwatch_log_group.for_lambda]
}

resource "aws_lambda_alias" "this" {
  count            = var.alias_cnt
  name             = var.alias_name
  function_name    = aws_lambda_function.for_api[count.index].arn
  function_version = var.func_version
}

resource "aws_lambda_function_recursion_config" "this" {
  count          = var.recursion_cnt
  function_name  = aws_lambda_function.for_api[count.index].name
  recursive_loop = var.recursive_loop
}

#resource "aws_lambda_permission" "api_gw" {
#  count = var.lambda_perm_cnt
#  statement_id  = var.perm_statement_id
#  action        = var.perm_action
#  function_name = aws_lambda_function.for_api[count.index].name
#  principal     = var.principal
#
#  #source_arn = "${aws_apigatewayv2_api.this.execution_arn}/*/*"
#  source_arn = "${var.exec_arn}/*/*"
#}

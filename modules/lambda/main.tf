data "aws_iam_policy_document" "this" {
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
  name               = var.lambda_role_name
  assume_role_policy = data.aws_iam_policy_document.this.json
}

data "archive_file" "for_lambda" {
  type        = var.archive_type
  source_dir  = "${path.module}/${var.source_dir}"
  output_path = "${path.module}/${var.dest_path}"
}

resource "aws_lambda_function" "for_api" {
  filename      = "${path.module}/${var.dest_path}"
  function_name = var.func_name
  role          = aws_iam_role.for_lambda.arn
  #handler = "index.handler"
  handler = var.handler
  runtime = var.lambda_runtime

}

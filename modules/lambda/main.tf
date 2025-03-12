#>>>>>
#Policy/role for Lambda itself
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


#Problem
#>>>>>
#Policy/role for Lambda access to CloudWatch
resource "aws_iam_role" "second" {
  name = var.second_role_name
  assume_role_policy = <<EOF
  {
    "Version": var.role_policy_version,
    "Statement": [{
        "Effect": var.role_policy_effect,
        "Principal": {
            "Service": var.role_policy_principal
        },
        "Action": var.actions[0]
    }]
  }
EOF
}

resource "aws_iam_policy" "access_to_clodwatch" {
  name = var.role_name
  policy = jsonencode({
    "Version" : var.role_policy_version
    "Statement" : [
      {
        Action : var.policy_action,
        Effect : var.sec_policy_effect,
        Resource : var.policy_resource
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "for_logging" {
  role = aws_iam_role.second.id
  policy_arn = aws_iam_policy.access_to_clodwatch.arn
}

resource "aws_cloudwatch_log_group" "for_lambda" {
  name = var.log_group_name
  retention_in_days = var.retention_days
#  lifecycle {
#    prevent_destroy = var.prevent_destroy
#  }
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

  depends_on = [aws_cloudwatch_log_group.for_lambda]
}

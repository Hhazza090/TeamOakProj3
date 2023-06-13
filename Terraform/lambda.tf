data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "iam_for_lambda" {
  name               = "OakLambda"

  assume_role_policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Sid       = ""
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_policy_attachment" "lambda_policies" {
  name       = "lambda-policies"
  roles      = [aws_iam_role.iam_for_lambda.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonRDSFullAccess"
}

resource "aws_iam_policy_attachment" "vpc_policies" {
  name       = "vpc-policies"
  roles      = [aws_iam_role.iam_for_lambda.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonVPCFullAccess"
}

resource "aws_iam_policy_attachment" "basic_execution_role" {
  name       = "basic-execution-role"
  roles      = [aws_iam_role.iam_for_lambda.name]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_policy_attachment" "vpc_access_execution_role" {
  name       = "vpc-access-execution-role"
  roles      = [aws_iam_role.iam_for_lambda.name]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}


resource "aws_lambda_function" "Oak_Lambda" {
  # If the file is not in the current working directory you will need to include a
  # path.module in the filename.
  filename      = "lambda_function_payload.zip"
  function_name = "${var.default_tags.env}-lambda"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "python.zip"

  source_code_hash = data.archive_file.lambda.output_base64sha256

  runtime = "python3.10"

  environment {
    variables = {
      foo = "bar"
    }
  }
}
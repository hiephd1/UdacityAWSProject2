# TODO: Designate a cloud provider, region, and credentials
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  access_key = "ASIA2J6TPJERA5LQT2TS"
  secret_key = "ME0ZEV4VTc9vDSiDqsR51BdIJTP9IJ/ZpZbIK7Ki"
  token = "FwoGZXIvYXdzEKj//////////wEaDO5Z1KtR1G6xDGdwSiLVAUhnI48YR0nX+kVkepbH0vYUDn5uGC0aOi+P746lI0cA4ur0k2Apw8Y+ujJ04cOi5QFVWXWovw7CFMYyjdEWlE1/2f0fXrgsXBYfVgieHwmAoARTDSACy5KARww2j/YYTdcAHKl2mS4iJq4d+/0Y+mY5cl5rSFl9mNmZ30ZToTnyhLD8tW4bvNc2CGNOtqiBEPNSU4UWQCa1UI/X55X6eXKRW/nURxVtoiPu3T7WcwfN9lXGMEhaItWk/uoKEfXOEQNyccTfsAJjkr3Im+vTrc91+nS6xCi14LemBjIt1m7oH97pqFQKLtIY+eMDUppn+7iJx49vDb6gYVh9K8hlQ0KJ2xM5Sc+s5zaL"
  region  = "us-east-1"
}

data "archive_file" "lambda_zip_file" {
    type = "zip"
    source_file = "project2_lambda.py"
    output_path = var.lambda_output_path
}

resource "aws_iam_role" "project2_lambda_role" {
  name = "project2_lambda_function_role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}


resource "aws_iam_policy" "iam_lambda_policy" {
  name        = "project2_iam_lambda_policy"
  path        = "/"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*",
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "attach_iam_policy_to_role" {
  role       = aws_iam_role.project2_lambda_role.name
  policy_arn = aws_iam_policy.iam_lambda_policy.arn
}

resource "aws_lambda_function" "project2_lambda" {
  function_name = var.lambda_name
  filename = data.archive_file.lambda_zip_file.output_path
  source_code_hash = data.archive_file.lambda_zip_file.output_base64sha256
  handler = "project2_lambda.lambda_handler"
  runtime = "python3.9"
  role = aws_iam_role.project2_lambda_role.arn

  environment{
      variables = {
          name = "HiepPD3"
      }
  }

  depends_on = [aws_iam_role_policy_attachment.attach_iam_policy_to_role]
}
 



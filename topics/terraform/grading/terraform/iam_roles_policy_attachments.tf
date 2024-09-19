resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  role       = aws_iam_role.lambda_api.name
  policy_arn = data.aws_iam_policy.lambda_basic_execution.arn
}

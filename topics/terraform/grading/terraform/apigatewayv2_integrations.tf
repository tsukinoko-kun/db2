resource "aws_apigatewayv2_integration" "grade_lambda" {
  api_id      = aws_apigatewayv2_api.api.id
  description = "Integration for grade Lambda"

  integration_type       = "AWS_PROXY"
  integration_uri        = aws_lambda_function.grade.invoke_arn
  payload_format_version = "2.0"
}

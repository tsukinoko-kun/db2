resource "aws_lambda_permission" "apigateway_execute_grade_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.grade.function_name
  principal     = "apigateway.amazonaws.com"

  # More: http://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-control-access-using-iam-policies-to-invoke-api.html
  source_arn = "arn:aws:execute-api:eu-central-1:${data.aws_caller_identity.current.account_id}:${aws_apigatewayv2_api.api.id}/*/GET/grade"
}

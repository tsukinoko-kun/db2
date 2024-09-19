resource "aws_apigatewayv2_route" "get_grade" {
  api_id    = aws_apigatewayv2_api.api.id
  route_key = "GET /grade"

  target = "integrations/${aws_apigatewayv2_integration.grade_lambda.id}"
}

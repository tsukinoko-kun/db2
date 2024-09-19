resource "aws_apigatewayv2_api" "api" {
  name          = var.api_name
  description   = "API gateway for terraform example"
  protocol_type = "HTTP"
}

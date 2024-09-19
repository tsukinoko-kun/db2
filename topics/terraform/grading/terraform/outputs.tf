# gives us a nice, clickable test url
output "test_grade_url" {
  value = "${aws_apigatewayv2_stage.default.invoke_url}grade?points=87&max=100"
}

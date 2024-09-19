resource "aws_lambda_function" "grade" {
  function_name = "grade"
  description   = "Returns grade based on points and max"

  filename         = data.archive_file.lambda_grade.output_path
  source_code_hash = filebase64sha256(data.archive_file.lambda_grade.output_path)

  role = aws_iam_role.lambda_api.arn

  runtime = "ruby3.2"
  handler = "handler.process"
}

data "archive_file" "lambda_grade" {
  type        = "zip"
  source_dir  = "../lambdas/grade"
  output_path = "../lambdas/grade.zip"
}

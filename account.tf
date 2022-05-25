resource "aws_api_gateway_account" "default" {
  cloudwatch_role_arn = var.cloudwatch_role_arn
}
resource "aws_api_gateway_method" "default" {
  rest_api_id   = aws_api_gateway_rest_api.default.id
  resource_id   = aws_api_gateway_resource.default.id
  http_method   = "ANY"
  authorization = var.method_authorization
  api_key_required = var.api_key_required
}
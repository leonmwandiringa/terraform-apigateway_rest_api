resource "aws_api_gateway_integration" "default" {
  rest_api_id          = aws_api_gateway_rest_api.default.id
  resource_id          = aws_api_gateway_resource.default.id
  http_method          = aws_api_gateway_method.default.http_method
  type                 = "MOCK"
  timeout_milliseconds = 29000

  request_parameters = {
    "integration.request.header.X-Authorization" = "'static'"
  }

  # Transforms the incoming XML request to JSON
  request_templates = {
    "application/xml" = <<EOF
{
   "body" : $input.json('$')
}
EOF
  }
}
resource "aws_api_gateway_authorizer" "default" {
  count = length(var.authorizers)
  name                   = var.authorizers[count.index].name
  type = var.authorizers[count.index].type
  rest_api_id            = aws_api_gateway_rest_api.default.id
  provider_arns = var.authorizers[count.index].provider_arns
}
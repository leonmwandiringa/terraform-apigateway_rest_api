resource "aws_api_gateway_authorizer" "default" {
  count = var.gateway_authorizers != null ? length(var.gateway_authorizers) : 0
  name                   = var.gateway_authorizers[count.index].name
  authorizer_uri = var.gateway_authorizers[count.index].authorizer_uri
  rest_api_id            = aws_api_gateway_rest_api.default.id
  type = var.gateway_authorizers[count.index].type
  provider_arns = var.gateway_authorizers[count.index].provider_arns
}
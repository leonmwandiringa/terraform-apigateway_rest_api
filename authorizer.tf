resource "aws_api_gateway_authorizer" "default" {
  count = var.authorizers != null ? length(var.authorizers) : 0
  name                   = var.authorizers[count.index].name
  rest_api_id            = aws_api_gateway_rest_api.default.id
  type = var.authorizers[count.index].type
  provider_arns = var.authorizers[count.index].provider_arns
}
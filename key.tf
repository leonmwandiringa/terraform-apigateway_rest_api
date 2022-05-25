resource "aws_api_gateway_api_key" "default" {
  count = length(var.stage) > 0 && var.create_keys == true ? 1 : 0
  name = "${var.name}_key"
}

resource "aws_api_gateway_usage_plan_key" "default" {
  count = length(var.stage) > 0 && var.create_keys == true ? 1 : 0
  key_id        = aws_api_gateway_api_key.default[0].id
  key_type      = "API_KEY"
  usage_plan_id = aws_api_gateway_usage_plan.default[0].id
}
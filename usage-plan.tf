resource "aws_api_gateway_api_key" "default" {
  count = length(var.usage_plans)
  name = "${var.usage_plans[count.index].name}_key"
}

resource "aws_api_gateway_usage_plan_key" "default" {
  count = length(var.usage_plans)
  key_id        = aws_api_gateway_api_key.default[count.index].id
  key_type      = "API_KEY"
  usage_plan_id = aws_api_gateway_usage_plan.default[count.index].id
}

resource "aws_api_gateway_usage_plan" "default" {
  count = length(var.usage_plans)
  name         = "${var.usage_plans[count.index].name}-plan"
  description  = "${var.usage_plans[count.index].name}-plan"

  dynamic "api_stages" {
      for_each = var.usage_plans[count.index].stages
      content {
        api_id = aws_api_gateway_rest_api.default.id
        stage  = api_stages.value
      }
  }

  throttle_settings {
    burst_limit = var.usage_plans[count.index].usage_plan_burst_limit
    rate_limit  = var.usage_plans[count.index].usage_plan_rate_limit
  }
  
  depends_on = [
    aws_api_gateway_stage.default
  ]
  
  tags = merge(
      var.tags,
      {
          "Name" = "${var.usage_plans[count.index].name}-plan"
      }
  )

}
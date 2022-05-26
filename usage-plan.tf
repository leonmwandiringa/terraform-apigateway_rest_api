resource "aws_api_gateway_usage_plan" "default" {
  count = length(var.stages) > 0 && var.create_keys == true ? 1 : 0
  name         = "${var.name}-plan"
  description  = "${var.name}-plan"

  dynamic "api_stages" {
      for_each = var.stages
      content {
        api_id = aws_api_gateway_rest_api.default.id
        stage  = api_stages.value
      }
  }
  
  dynamic "quota_settings" {
    for_each = length(var.quota_settings) > 0 ? var.quota_settings : []
    content {
      limit  = quota_settings.value.limit
      offset = quota_settings.value.offset
      period = quota_settings.value.period
    }
  }

  dynamic "throttle_settings" {
    for_each = length(var.throttle_settings) > 0 ? var.throttle_settings : []
    content {
      burst_limit = throttle_settings.value.burst_limit
      rate_limit  = throttle_settings.value.rate_limit
    }
  }
  
  tags = merge(
      var.tags,
      {
          "Name" = "${var.name}-plan"
      }
  )
}
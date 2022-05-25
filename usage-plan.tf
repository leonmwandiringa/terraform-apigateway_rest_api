resource "aws_api_gateway_usage_plan" "default" {
  name         = "${var.name}-plan"
  description  = "${var.name}-plan"

  dynamic "api_stages" {
      for_each = var.stages
      content {
        api_id = aws_api_gateway_rest_api.default.id
        stage  = api_stages.value
      }
  }
  
  tags = merge(
      var.tags,
      {
          "Name" = "${var.name}-plan"
      }
  )
#   quota_settings {
#     limit  = 20
#     offset = 2
#     period = "WEEK"
#   }

#   throttle_settings {
#     burst_limit = 5
#     rate_limit  = 10
#   }
}
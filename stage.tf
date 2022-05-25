resource "aws_api_gateway_stage" "default" {
  count                = length(var.stages) > 0 ? length(var.stages) : 0
  deployment_id        = aws_api_gateway_deployment.default.id
  rest_api_id          = aws_api_gateway_rest_api.default.id
  stage_name           = var.stages[count.index]
  xray_tracing_enabled = var.xray_tracing_enabled
  tags                 = merge({
      "Name" = "apig stage ${var.stages[count.index]}"
    },
    var.tags
  )

  dynamic "access_log_settings" {
    for_each = var.log_group_arn != null ? [1] : []

    content {
      destination_arn = var.log_group_arn
      format          = replace(var.access_log_format, "\n", "")
    }
  }

  depends_on = [
    aws_api_gateway_account.default
  ]
}
# resource "aws_api_gateway_method_settings" "default" {
#   count = length(var.stages) > 0 ? length(var.stages) : 0
#   rest_api_id = aws_api_gateway_rest_api.default.id
#   stage_name  = var.stages[count.index]
#   method_path = "*/*"

#   settings {
#     metrics_enabled = var.metrics_enabled
#     logging_level   = var.logging_level
#   }
# }
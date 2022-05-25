resource "aws_api_gateway_rest_api" "default" {
  name = var.name
  body = var.openapi_config != null ? jsonencode(var.openapi_config) : null
  tags = var.tags

  endpoint_configuration {
    types = [var.endpoint_type]
    vpc_endpoint_ids = [var.vpc_endpoint_id]
  }

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": "execute-api:Invoke",
      "Resource": "*"
    },
    {
            "Effect": "Deny",
            "Principal": "*",
            "Action": "execute-api:Invoke",
            "Resource": [
                "*"
            ],
            "Condition" : {
                "StringNotEquals": {
                    "aws:SourceVpce": "${var.vpc_endpoint_id}"
                }
            }
        }
  ]
}
EOF
}
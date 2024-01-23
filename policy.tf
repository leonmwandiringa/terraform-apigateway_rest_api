resource "aws_api_gateway_rest_api_policy" "default" {
  count = length(var.vpc_endpoint_id) > 0 ? 1 : 0
  rest_api_id = aws_api_gateway_rest_api.default.id
  depends_on = [
    aws_api_gateway_rest_api.default
  ]
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
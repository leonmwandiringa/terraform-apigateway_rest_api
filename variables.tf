variable "tags" {
  type = object({
    Author      = string
    Environment = string
    Provisioner = string
    Region      = string
  })
  description = "base tags required in every resource"
}

variable "name" {
  type = string
  description = "apigateway rest name"
}

variable "usage_plans" {
  type = list(object({
    name = string
    stages = list(string)
    usage_plan_burst_limit = number
    usage_plan_rate_limit = number
  }))
  description = "gateway authorizer list"
  default = []
}

variable "openapi_config" {
  description = "The OpenAPI specification for the API"
  type        = any
  default     = null
}
variable "stages" {
  type = list(string)
  description = "stages list"
  default = []
}
variable "resource_path_part" {
  type = string
  default = "default"
}

variable "usage_plan_burst_limit" {
  type = number
  default = 5000
}

variable "usage_plan_rate_limit" {
  type = number
  default = 10000
}

variable "vpc_endpoint_id" {
  type = list(string)
  default = []
}
variable "endpoint_type" {
  type        = string
  description = "The type of the endpoint. One of - PUBLIC, PRIVATE, REGIONAL"
  default     = "REGIONAL"

  validation {
    condition     = contains(["EDGE", "REGIONAL", "PRIVATE"], var.endpoint_type)
    error_message = "Valid values for var: endpoint_type are (EDGE, REGIONAL, PRIVATE)."
  }
}

variable "logging_level" {
  type        = string
  description = "The logging level of the API. One of - OFF, INFO, ERROR"
  default     = "INFO"

  validation {
    condition     = contains(["OFF", "INFO", "ERROR"], var.logging_level)
    error_message = "Valid values for var: logging_level are (OFF, INFO, ERROR)."
  }
}

variable "cloudwatch_role_arn" {
  type = string
  description = "role arn"
}

variable "api_key_required" {
  type = bool
  default = false
}

variable "method_authorization" {
  type = string
  default = "NONE"
}
variable "metrics_enabled" {
  description = "A flag to indicate whether to enable metrics collection."
  type        = bool
  default     = false
}

variable "log_group_arn" {
  type = string
  description = "logn group name"
}

variable "xray_tracing_enabled" {
  description = "A flag to indicate whether to enable X-Ray tracing."
  type        = bool
  default     = false
}

variable "authorizers" {
  type = list(object({
    name = string
    type = string
    provider_arns = list(string) # for cognito
  }))
  description = "gateway authorizer list"
  default = null
}

# See https://docs.aws.amazon.com/apigateway/latest/developerguide/set-up-logging.html for additional information
# on how to configure logging.
variable "access_log_format" {
  description = "The format of the access log file."
  type        = string
  default     = "{\"requestTime\": \"$context.requestTime\",\"requestId\": \"$context.requestId\",\"httpMethod\": \"$context.httpMethod\",\"path\": \"$context.path\",\"resourcePath\": \"$context.resourcePath\",\"status\": $context.status,\"responseLatency\": $context.responseLatency,\"xrayTraceId\": \"$context.xrayTraceId\",\"integrationRequestId\": \"$context.integration.requestId\",\"functionResponseStatus\": \"$context.integration.status\",\"integrationLatency\": \"$context.integration.latency\",\"integrationServiceStatus\": \"$context.integration.integrationStatus\",\"authorizeResultStatus\": \"$context.authorize.status\",\"authorizerServiceStatus\": \"$context.authorizer.status\",\"authorizerLatency\": \"$context.authorizer.latency\",\"authorizerRequestId\": \"$context.authorizer.requestId\",\"ip\": \"$context.identity.sourceIp\",\"userAgent\": \"$context.identity.userAgent\",\"principalId\": \"$context.authorizer.principalId\",\"cognitoUser\": \"$context.identity.cognitoIdentityId\",\"user\": \"$context.identity.user\"}"
}

# See https://docs.aws.amazon.com/apigateway/latest/developerguide/apigateway-resource-policies.html for additional
# information on how to configure resource policies.
#
# Example:
# {
#    "Version": "2012-10-17",
#    "Statement": [
#        {
#            "Effect": "Allow",
#            "Principal": "*",
#            "Action": "execute-api:Invoke",
#            "Resource": "arn:aws:execute-api:us-east-1:000000000000:*"
#        },
#        {
#            "Effect": "Deny",
#            "Principal": "*",
#            "Action": "execute-api:Invoke",
#            "Resource": "arn:aws:execute-api:region:account-id:*",
#            "Condition": {
#                "NotIpAddress": {
#                    "aws:SourceIp": "123.4.5.6/24"
#                }
#            }
#        }
#    ]
#}
variable "rest_api_policy" {
  description = "The IAM policy document for the API."
  type        = string
  default     = null
}

variable "private_link_target_arns" {
  type        = list(string)
  description = "A list of target ARNs for VPC Private Link"
  default     = []
}
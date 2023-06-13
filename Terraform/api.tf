resource "aws_api_gateway_rest_api" "Team-oak" {
  body = jsonencode({
    openapi = "3.0.1"
    info = {
      title   = "Team-oak"
      version = "1.0"
    }
    paths = {
      "/path1" = {
        get = {
          x-amazon-apigateway-integration = {
            httpMethod           = "POST"
            payloadFormatVersion = "1.0"
            type                 = "HTTP_PROXY"
            uri                  = "https://ip-ranges.amazonaws.com/ip-ranges.json"
            # uri                  = "https://ip-ranges.amazonaws.com/ip-ranges.json"
          }
        }
      }
    }
  })

  name = "Team-oak"

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_deployment" "Team-oak" {
  rest_api_id = aws_api_gateway_rest_api.Team-oak.id

  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_rest_api.Team-oak.body))
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "Team-oak" {
  deployment_id = aws_api_gateway_deployment.Team-oak.id
  rest_api_id   = aws_api_gateway_rest_api.Team-oak.id
  stage_name    = "Team-oak"
}
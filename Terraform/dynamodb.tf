resource "aws_dynamodb_table" "dynamodb-table" {
  name           = "Team-Oak-project-3"
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "name"
  range_key      = "email"

  attribute {
    name = "name"
    type = "S"
  }

  attribute {
    name = "email"
    type = "S"
  }

  # attribute {
  #   name = "location"
  #   type = "S"
  # }
  # attribute {
  #   name = "option"
  #   type = "S"
  # }
  # attribute {
  #   name = "phone"
  #   type = "N"
  # }

  # ttl {
  #   attribute_name = "TimeToExist"
  #   enabled        = false
  # }

  # global_secondary_index {
  #   name               = "GameTitleIndex"
  #   hash_key           = "name"
  #   range_key          = "email"
  #   write_capacity     = 10
  #   read_capacity      = 10
  #   projection_type    = "INCLUDE"
  #   non_key_attributes = ["UserId"]
  # }

  tags = {
    Name        = "dynamodb-table-1"
    Environment = "production"
  }
}
# provider "aws" {
#   alias  = "us_east_1"
#   region = "us-east-1"
# }

# resource "aws_ecrpublic_repository" "oak_ecr" {
#   provider = aws.us_east_1

#   repository_name = "oak-ecr"

#   catalog_data {
    
#     description       = "ECR for Oak from terraform"
  
#   }
#   lifecycle {
#     prevent_destroy = true
#   }
#   tags = {
#     env = "${var.default_tags.env}-ECR"
#   }
# }
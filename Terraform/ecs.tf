resource "aws_ecs_cluster" "ECS" {
  name = "${var.default_tags.env}-ECS"
  lifecycle {
    prevent_destroy = true
  }
  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}
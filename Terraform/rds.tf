# module "db_sg" {
#   source = "./modules/rds"
#   sg_name = "${var.default_tags.env}-DB-SG"
#   sg_source = aws_subnet.private[*].id
#   description = "SG for RDS portion of Terraform Demo"
#   vpc_id = aws_vpc.main.id
#   sg_db_ingress = var.sg_db_ingress
#   sg_db_egress = var.sg_db_egress
# }

# db subnet group
resource "aws_db_subnet_group" "db" {
  name_prefix = "team-oak-db"
  subnet_ids = aws_subnet.private[*].id 
  tags = {
    Name = "${var.default_tags.env}-group"
  }
}

# # cluster
# resource "aws_rds_cluster" "db" {
#   cluster_identifier = "oak-cluster"
#   db_subnet_group_name = aws_db_subnet_group.db.name
#   engine = "aurora-postgresql"
#   engine_mode = "provisioned"
#   availability_zones = aws_subnet.private[*].availability_zone
#   engine_version = "13.6"
#   serverlessv2_scaling_configuration {
#     max_capacity = 1.0
#     min_capacity = 0.5
#   }
#   database_name = "teamoakdb" 
#   vpc_security_group_ids = [module.db_sg.sg_id]
#   master_username = var.db_credentials.username
#   master_password = var.db_credentials.password
#   skip_final_snapshot = true

#   tags = {
#     "Name" = "${var.default_tags.env}-cluster"
#   }
# }

# # cluster instances
# resource "aws_rds_cluster_instance" "db" {
#   count = 2
#   identifier = "teamoak-${count.index+1}"
#   cluster_identifier = aws_rds_cluster.db.id
#   instance_class = "db.serverless"
#   engine = aws_rds_cluster.db.engine
#   engine_version = aws_rds_cluster.db.engine_version
#   db_subnet_group_name = aws_db_subnet_group.db.name
# }

# # DB endpoints
# output "db_endpoints" {
#   value = {
#     writer = aws_rds_cluster.db.endpoint
#     reader = aws_rds_cluster.db.reader_endpoint
#   }
# }




# resource "aws_security_group" "allow_tls" {
#   name        = "allow_tls"
#   description = "Allow TLS inbound traffic"
#   vpc_id      = aws_vpc.main.id

#   ingress {
#     description      = "TLS from VPC"
#     from_port        = 443
#     to_port          = 443
#     protocol         = "tcp"
#     cidr_blocks      = [aws_vpc.main.cidr_block]
#     ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
#   }

#   egress {
#     from_port        = 0
#     to_port          = 0
#     protocol         = "-1"
#     cidr_blocks      = ["0.0.0.0/0"]
#     ipv6_cidr_blocks = ["::/0"]
#   }

#   tags = {
#     Name = "allow_tls"
#   }
# }
locals {
  db_name = "petclinic"
}

resource "aws_db_instance" "petclinic_db" {
  identifier                            = local.db_name
  option_group_name                     = "default:mysql-5-7"
  parameter_group_name                  = "default.mysql5.7"
  allocated_storage                     = 20
  storage_type                          = "gp2"
  engine                                = "mysql"
  engine_version                        = "5.7.22"
  license_model                         = "general-public-license"
  instance_class                        = "db.t3.micro"
  username                              = "admin"
  password                              = var.password
  port                                  = 3306
  multi_az                              = false
  backup_retention_period               = 7
  backup_window                         = "00:00-00:30"
  maintenance_window                    = "sun:06:10-sun:06:40"
  auto_minor_version_upgrade            = true
  copy_tags_to_snapshot                 = true
  db_subnet_group_name                  = var.subnet_group
  deletion_protection                   = false
  enabled_cloudwatch_logs_exports       = []
  monitoring_interval                   = "60"
  monitoring_role_arn                   = "arn:aws:iam::456204685070:role/rds-monitoring-role"
  performance_insights_enabled          = false
  performance_insights_retention_period = 0
  iam_database_authentication_enabled   = false
  iops                                  = 0
  publicly_accessible                   = true
  vpc_security_group_ids = [
    data.aws_security_group.vpc_sg.id,
  ]
  skip_final_snapshot = true

  tags = {
    "mdf:environment" = var.environment
    "mdf:platform"    = "intertrade"
    "mdf:group"       = "rnd"
    "mdf:resource"    = "petclinic"
    "mdf:terraform"   = "true"
    "workload-type"   = "other"
  }
}

# data "aws_kms_key" "rds_key" {
#   key_id = "alias/aws/rds"
# }

data "aws_vpc" "selected" {
  id = var.vpc_id
}

data "aws_security_group" "vpc_sg" {
  name   = "default"
  vpc_id = data.aws_vpc.selected.id
}
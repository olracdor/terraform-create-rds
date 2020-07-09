locals {
  port                  = var.port == "" ? var.engine == "aurora-postgresql" ? "5432" : "3306" : var.port
  db_subnet_group_name  = var.db_subnet_group_name == "" ? join("", aws_db_subnet_group.this.*.name) : var.db_subnet_group_name
  name                  = var.name
  rds_security_group_id = join("", aws_security_group.this.*.id)
}

resource "aws_db_subnet_group" "this" {
  count = var.db_subnet_group_name == "" ? 1 : 0

  name        = var.name
  description = "For Aurora cluster ${var.name}"
  subnet_ids  = var.subnets

  tags = merge(var.tags, {
    Name = local.name
  })
}

resource "aws_security_group" "this" {
  count = var.create_security_group ? 1 : 0

  name_prefix = "${var.name}-"
  vpc_id      = var.vpc_id

  description = "Control traffic to/from RDS Aurora ${var.name}"

  tags = merge(var.tags, {
    Name = local.name
  })
}
resource "aws_rds_cluster" "this" {
  cluster_identifier              = "aurora-cluster-${var.name}"
  enable_http_endpoint            = var.enable_http_endpoint
  engine                          = var.engine
  engine_mode                     = var.engine_mode
  engine_version                  = var.engine_version
  database_name                   = local.name
  master_username                 = var.username
  master_password                 = var.password
  port                            = local.port
  db_subnet_group_name            = local.db_subnet_group_name
  db_cluster_parameter_group_name = var.db_cluster_parameter_group_name
  tags                            = var.tags
}

resource "aws_rds_cluster_instance" "this" {
  count                   = var.instance_count
  identifier              = "aurora-cluster-${var.name}-${count.index}"
  cluster_identifier      = aws_rds_cluster.this.id
  engine                  = var.engine
  engine_version          = var.engine_version
  instance_class          = var.instance_type
  db_subnet_group_name    = local.db_subnet_group_name
  apply_immediately       = true
  db_parameter_group_name = var.db_parameter_group_name
  tags                    = var.tags
}

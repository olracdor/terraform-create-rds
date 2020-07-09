data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "all" {
  vpc_id = data.aws_vpc.default.id
}

provider "aws" {
  region     = "ap-southeast-2"
  access_key = "PUT KEY HERE WITH CAUTION"
  secret_key = "PUT SECRET HERE WITH CAUTION"
}

module "aurora" {
  source                          = "../../"
  enable_http_endpoint            = true
  name                            = "sample"
  engine                          = "aurora"
  engine_mode                     = "serverless"
  instance_type                   = "db.t2.small"
  vpc_id                          = data.aws_vpc.default.id
  subnets                         = data.aws_subnet_ids.all.ids
  db_parameter_group_name         = aws_db_parameter_group.sample_db_postgres96_parameter_group.id
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.sample_cluster_postgres96_parameter_group.id
  instance_count                  = 0
}

resource "aws_db_parameter_group" "sample_db_postgres96_parameter_group" {
  name        = "sample-db-parameter-group"
  family      = "aurora5.6"
  description = "sample-db-parameter-group"
}

resource "aws_rds_cluster_parameter_group" "sample_cluster_postgres96_parameter_group" {
  name        = "sample-db-cluster-parameter-group"
  family      = "aurora5.6"
  description = "sample-db-cluster-parameter-group"
}
/*
resource "null_resource" "setup_db" {
  depends_on = [module.aurora] 
  provisioner "local-exec" {
    command = "mysql -u ${module.aurora.aws_rds_cluster_this_username} -p ${module.aurora.aws_rds_cluster_this_password} -h ${module.aurora.this_rds_cluster_endpoint} < ./tables.sql"
  }
}
*/
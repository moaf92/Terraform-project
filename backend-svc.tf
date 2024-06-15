resource "aws_db_subnet_group" "rds-subgrp" {
  name = "rds-subgrp"
  subnet_ids = [module.vpc.private_subnets[0], module.vpc.private_subnets[1], module.vpc.private_subnets[2] ]  
  tags = {
    Name = "subnet group for RDS"
  }  
}

resource "aws_elasticashe_subnet_group" "ecashe-subgrp" {
  name = "ecashe-subgrp"
  subnet_ids = [module.vpc.private_subnets[0], module.vpc.private_subnets[1], module.vpc.private_subnets[2] ]  
}

resource "aws_db_instance" "project-rds" {
    
    allocated_storage = 20
    storage_type = "gp2"
    engine = "mysql"
    engine_version = "5.6.34"
    instance_class = "db.t2.micro"
    name = var.dbname
    username = var.dbuser
    password =  var.dbpass
    parameter_group_name = "default.mysql5.6"
    multi_az = "false"
    publicly_accessible = "false"
    skip_final_snapshot = true
    db_subnet_group_name = aws_db_subnet_group.rds-subgrp.name
    vpc_security_group_ids = [aws_security_group.backend-sg.id]
  
}
resource "aws_elasticashe_cluster" "project-cashe" {
    cluster_id = "project-cashe"
    engine = "memcashed"
    node_type = "cashe.t2.micro"
    num_cashe_nodes = 1
    parameter_group_name = "default.memcashed1.5"
    port = 11211
    subnet_group_name = aws_elasticashe_subnet_group.ecashe-subgrp.name
    security_group_ids = [aws_security_group.backend-sg.id]
  
}
resource "aws_mq_broker" "project-mq" {
  broker_name = "prject-mq"
  engine_type = "ActiveMQ"
  engine_version = "5.15.14"  
  host_instance_type = "mq.t2.micro"  

  security_groups = [aws_security_group.backend-sg.id]  
  subnet_ids = [module.vpc.private_subnets[0]]
  user {
    username = var.rmquser  
    password = var.rmqpass
  }
}  
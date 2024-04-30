# Provisions MySQL RDS Instance 
resource "aws_db_instance" "mysql" {
  allocated_storage        = var.MYSQL_STORAGE
  identifier               = "roboshop-${var.ENV}-mysql"
  engine                   = var.MYSQL_ENGINE
  engine_version           = var.MYSQL_ENGINE_VERSION
  instance_class           = var.MYSQL_INSTANCE_TYPE
  username                 = jsondecode(data.aws_secretsmanager_secret_version.secret_version.secret_string)["RDS_USERNAME"]  
  password                 = jsondecode(data.aws_secretsmanager_secret_version.secret_version.secret_string)["RDS_PASSWORD"]
  parameter_group_name     = aws_db_parameter_group.mysql.name 
  skip_final_snapshot      = var.MYSQL_SKIP_SNAPSHOT 
  db_subnet_group_name     = aws_db_subnet_group.mysql.name 
  vpc_security_group_ids   = [aws_security_group.allow_mysql.id]
}

# Provisons Parameter Groups for RDS
resource "aws_db_parameter_group" "mysql" {
  name                = "rds-pg"
  family              = var.MYSQL_ENGINE_FAMILY
}

# Provisions Subnet Group
resource "aws_db_subnet_group" "mysql" {
  name                = "roboshop-${var.ENV}-mysql"
  subnet_ids          = data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNET_IDS

  tags = {
    Name = "roboshop-${var.ENV}-mysql"
  }
}

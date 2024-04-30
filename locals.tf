locals {
  RDS_USERNAME = jsondecode(data.aws_secretsmanager_secret_version.secret_version.secret_string)["RDS_USERNAME"]  
  RDS_PASSWORD = jsondecode(data.aws_secretsmanager_secret_version.secret_version.secret_string)["RDS_PASSWORD"]
}


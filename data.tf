# datasource that reads the info from vpc statefile 
data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "b57-tf-state-bucket"
    key    = "dev/vpc/terraform.tfstate"
    region = "us-east-1"
  }
}

# Extracts the secret's metadata
data "aws_secretsmanager_secret" "secrets" {
  name     = "robot/secrets"
}

# Extracting the secret version from the secret
data "aws_secretsmanager_secret_version" "secret_version" {
  secret_id = data.aws_secretsmanager_secret.secrets.id
}

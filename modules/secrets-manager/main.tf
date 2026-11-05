resource "aws_secretsmanager_secret" "database" {
  name        = var.secret_name
  description = var.description

  tags = {
    Name        = var.secret_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}


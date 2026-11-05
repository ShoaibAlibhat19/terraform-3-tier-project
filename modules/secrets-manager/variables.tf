variable "secret_name" {
  description = "Name of the secret in AWS Secrets Manager"
  type        = string
}

variable "description" {
  description = "Description of the secret"
  type        = string
  default     = "Database credentials for the application"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "dev"
}


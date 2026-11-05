
variable "vpc_id" {
  description = "VPC ID for security groups"
  type        = string
}

variable "allowed_ssh_cidr" {
  description = "Allowed CIDR blocks for SSH access"
  type        = list(string)
}

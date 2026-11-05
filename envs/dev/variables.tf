# ─────────────────────────────
# AWS
# ─────────────────────────────

variable "aws_region" {
  type = string
}


# ─────────────────────────────
# VPC
# ─────────────────────────────

variable "vpc_cidr" {
  type = string
}

variable "vpc_name" {
  type = string
}

variable "public_subnet_1_cidr" {
  type = string
}

variable "public_subnet_2_cidr" {
  type = string
}

variable "private_subnet_1_cidr" {
  type = string
}

variable "private_subnet_2_cidr" {
  type = string
}

variable "private_subnet_3_cidr" {
  type = string
}

variable "private_subnet_4_cidr" {
  type = string
}

variable "private_subnet_5_cidr" {
  type = string
}

variable "private_subnet_6_cidr" {
  type = string
}

variable "availability_zone_1a" {
  type = string
}

variable "availability_zone_1b" {
  type = string
}


# ─────────────────────────────
# SECURITY
# ─────────────────────────────

variable "allowed_ssh_cidr" {
  type = list(string)
}


# ─────────────────────────────
# EC2
# ─────────────────────────────

variable "ami" {
  type = string
}

variable "key_name" {
  type = string
}

variable "frontend_instance_type" {
  type = string
}

variable "backend_instance_type" {
  type = string
}

variable "bastion_instance_type" {
  type = string
}


# ─────────────────────────────
# LOAD BALANCERS
# ─────────────────────────────

variable "frontend_alb_name" {
  type = string
}

variable "frontend_target_group_name" {
  type = string
}

variable "backend_alb_name" {
  type = string
}

variable "backend_target_group_name" {
  type = string
}


# ─────────────────────────────
# RDS
# ─────────────────────────────

variable "project_name" {
  type = string
}

variable "db_identifier" {
  type = string
}

variable "db_allocated_storage" {
  type = number
}

variable "db_engine" {
  type = string
}

variable "db_engine_version" {
  type = string
}

variable "db_instance_class" {
  type = string
}

variable "db_multi_az" {
  type = bool
}

variable "db_name" {
  type = string
}

variable "db_username" {
  type = string
}

variable "db_password" {
  type      = string
  sensitive = true
}


# ─────────────────────────────
# FRONTEND LAUNCH TEMPLATE
# ─────────────────────────────

variable "frontend_lt_project_name" {
  type = string
}

variable "frontend_lt_instance_type" {
  type = string
}

variable "frontend_lt_key_name" {
  type = string
}


# ─────────────────────────────
# BACKEND LAUNCH TEMPLATE
# ─────────────────────────────

variable "backend_lt_project_name" {
  type = string
}

variable "backend_lt_instance_type" {
  type = string
}

variable "backend_lt_key_name" {
  type = string
}


# ─────────────────────────────
# BACKEND ASG
# ─────────────────────────────

variable "backend_asg_project_name" {
  type = string
}

variable "backend_desired_capacity" {
  type = number
}

variable "backend_min_size" {
  type = number
}

variable "backend_max_size" {
  type = number
}

variable "backend_scale_out_target_value" {
  type = number
}


# ─────────────────────────────
# FRONTEND ASG
# ─────────────────────────────

variable "frontend_asg_project_name" {
  type = string
}

variable "frontend_desired_capacity" {
  type = number
}

variable "frontend_min_size" {
  type = number
}

variable "frontend_max_size" {
  type = number
}

variable "frontend_scale_out_target_value" {
  type = number
}


# ─────────────────────────────
# ACM
# ─────────────────────────────

variable "certificate_name" {
  type = string
}

variable "domain_name" {
  type = string
}

variable "subject_alternative_names" {
  type = list(string)
}

variable "route53_zone_id" {
  type = string
}


# ─────────────────────────────
# CLOUDFRONT
# ─────────────────────────────

variable "distribution_comment" {
  type = string
}

variable "domain_names" {
  type = list(string)
}
# ─────────────────────────────
# PROJECT ENVIRONMENT
# ─────────────────────────────

variable "environment" {
  description = "Deployment environment"
  type        = string
}
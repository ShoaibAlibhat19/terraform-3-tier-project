# ─────────────────────────────
# AWS
# ─────────────────────────────

aws_region = "us-east-1"


# ─────────────────────────────
# VPC
# ─────────────────────────────

vpc_cidr = "10.0.0.0/16"
vpc_name = "prod-vpc"

public_subnet_1_cidr = "10.0.1.0/24"
public_subnet_2_cidr = "10.0.2.0/24"

private_subnet_1_cidr = "10.0.3.0/24"
private_subnet_2_cidr = "10.0.4.0/24"
private_subnet_3_cidr = "10.0.5.0/24"
private_subnet_4_cidr = "10.0.6.0/24"
private_subnet_5_cidr = "10.0.7.0/24"
private_subnet_6_cidr = "10.0.8.0/24"

availability_zone_1a = "us-east-1a"
availability_zone_1b = "us-east-1b"


# ─────────────────────────────
# SECURITY
# ─────────────────────────────

allowed_ssh_cidr = ["YOUR_PUBLIC_IP/32"]


# ─────────────────────────────
# EC2
# ─────────────────────────────

ami      = "ami-04b938437b69a2c9c"
key_name = "us-east-1"

frontend_instance_type = "t2.medium"
backend_instance_type  = "t2.micro"
bastion_instance_type  = "t2.micro"


# ─────────────────────────────
# LOAD BALANCERS
# ─────────────────────────────

frontend_alb_name          = "frontend-alb"
frontend_target_group_name = "frontend-tg"

backend_alb_name          = "backend-alb"
backend_target_group_name = "backend-tg"


# ─────────────────────────────
# RDS
# ─────────────────────────────

project_name = "three-tier"
db_identifier = "book-rds"

db_allocated_storage = 20
db_engine            = "mysql"
db_engine_version    = "8.0"
db_instance_class    = "db.t3.micro"
db_multi_az          = false

db_name     = "bookdb"
db_username = "admin"
db_password = "shoaib123"

# Supply the password using TF_VAR_db_password.
# Do not commit database passwords to Git.


# ─────────────────────────────
# FRONTEND LAUNCH TEMPLATE
# ─────────────────────────────

frontend_lt_project_name  = "three-tier"
frontend_lt_instance_type = "t3.micro"
frontend_lt_key_name      = "us-east-1"


# ─────────────────────────────
# BACKEND LAUNCH TEMPLATE
# ─────────────────────────────

backend_lt_project_name  = "three-tier"
backend_lt_instance_type = "t3.micro"
backend_lt_key_name      = "us-east-1"


# ─────────────────────────────
# BACKEND ASG
# ─────────────────────────────

backend_asg_project_name = "books-three-tier"

backend_desired_capacity = 1
backend_min_size         = 1
backend_max_size         = 3

backend_scale_out_target_value = 80


# ─────────────────────────────
# FRONTEND ASG
# ─────────────────────────────

frontend_asg_project_name = "books-three-tier"

frontend_desired_capacity = 1
frontend_min_size         = 1
frontend_max_size         = 3

frontend_scale_out_target_value = 80


# ─────────────────────────────
# ACM
# ─────────────────────────────

certificate_name = "three-tier-certificate"

domain_name = "992382432902.realhandsonlabs.net"

subject_alternative_names = [
  "www.992382432902.realhandsonlabs.net"
]

route53_zone_id = "Z0825265EO9UMFHBELIS"


# ─────────────────────────────
# CLOUDFRONT
# ─────────────────────────────

distribution_comment = "three-tier-cloudfront"

domain_names = [
  "992382432902.realhandsonlabs.net",
  "www.992382432902.realhandsonlabs.net"
]
environment  = "dev"
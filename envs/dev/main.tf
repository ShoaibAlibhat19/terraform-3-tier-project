# ─────────────────────────────
# VPC
# ─────────────────────────────

module "vpc" {
  source = "../../modules/networking"

  aws_region = var.aws_region
  vpc_cidr   = var.vpc_cidr
  vpc_name   = var.vpc_name

  public_subnet_1_cidr = var.public_subnet_1_cidr
  public_subnet_2_cidr = var.public_subnet_2_cidr

  private_subnet_1_cidr = var.private_subnet_1_cidr
  private_subnet_2_cidr = var.private_subnet_2_cidr
  private_subnet_3_cidr = var.private_subnet_3_cidr
  private_subnet_4_cidr = var.private_subnet_4_cidr
  private_subnet_5_cidr = var.private_subnet_5_cidr
  private_subnet_6_cidr = var.private_subnet_6_cidr

  availability_zone_1a = var.availability_zone_1a
  availability_zone_1b = var.availability_zone_1b
}


# ─────────────────────────────
# SECURITY
# ─────────────────────────────

module "security" {
  source = "../../modules/security"

  vpc_id           = module.vpc.vpc_id
  allowed_ssh_cidr = var.allowed_ssh_cidr
}


# ─────────────────────────────
# FRONTEND EC2
# ─────────────────────────────

# module "frontend-ec2" {
#   source = "../../modules/frontend/ec2"

#   aws_region        = var.aws_region
#   ami               = var.ami
#   instance_type     = var.frontend_instance_type
#   key_name          = var.key_name
#   subnet_id         = module.vpc.public_subnets[0]
#   security_group_id = module.security.bastion_host_sg_id
# }


# ─────────────────────────────
# BACKEND EC2
# ─────────────────────────────

module "backend-ec2" {
  source = "../../modules/backend/ec2"

  aws_region        = var.aws_region
  ami               = var.ami
  instance_type     = var.backend_instance_type
  key_name          = var.key_name
  subnet_id         = module.vpc.public_subnets[0]
  security_group_id = module.security.bastion_host_sg_id
}


# ─────────────────────────────
# BASTION HOST
# ─────────────────────────────

# module "bastion" {
#   source = "../../modules/bastion"

#   aws_region        = var.aws_region
#   ami               = var.ami
#   instance_type     = var.bastion_instance_type
#   key_name          = var.key_name
#   subnet_id         = module.vpc.public_subnets[0]
#   security_group_id = module.security.bastion_host_sg_id
# }


# ─────────────────────────────
# FRONTEND ALB
# ─────────────────────────────

# module "frontend_alb" {
#   source = "../../modules/frontend/loadbalancer"

#   aws_region        = var.aws_region
#   vpc_id            = module.vpc.vpc_id
#   subnets           = module.vpc.public_subnets
#   security_group_id = module.security.alb_frontend_sg_id

#   alb_name          = var.frontend_alb_name
#   target_group_name = var.frontend_target_group_name
#   certificate_arn   = module.acm.certificate_arn
# }


# ─────────────────────────────
# BACKEND ALB
# ─────────────────────────────

# module "backend_alb" {
#   source = "../../modules/backend/loadbalancer"

#   aws_region        = var.aws_region
#   vpc_id            = module.vpc.vpc_id
#   subnets           = module.vpc.public_subnets
#   security_group_id = module.security.alb_backend_sg_id

#   alb_name          = var.backend_alb_name
#   target_group_name = var.backend_target_group_name
# }


# ─────────────────────────────
# RDS DATABASE
# ─────────────────────────────

module "rds" {
  source = "../../modules/database"

  aws_region   = var.aws_region
  project_name = var.project_name
  identifier   = var.db_identifier

  allocated_storage = var.db_allocated_storage
  engine            = var.db_engine
  engine_version    = var.db_engine_version
  instance_class    = var.db_instance_class
  multi_az          = var.db_multi_az

  db_name     = var.db_name
  db_username = var.db_username
  db_password = var.db_password

  db_subnet_1_id = module.vpc.private_db_subnets[0]
  db_subnet_2_id = module.vpc.private_db_subnets[1]

  rds_sg_id = module.security.database_sg_id
}



module "secrets_manager" {
  source = "../../modules/secrets-manager"

  secret_name = "${var.project_name}/${var.environment}/database"
  description = "Database credentials for ${var.project_name}"
  environment = var.environment
}






# ─────────────────────────────
# FRONTEND LAUNCH TEMPLATE
# Remains commented out
# ─────────────────────────────

# module "frontend_launchtemplate" {
#   source = "../../modules/frontend/launch-template"
#
#   aws_region   = var.aws_region
#   project_name = var.frontend_lt_project_name
#
#   instance_type  = var.frontend_lt_instance_type
#   frontend_sg_id = module.security.backend_server_sg_id
#   key_name       = var.frontend_lt_key_name
#
#   instanceid = module.frontend-ec2.frontend_instanceid
# }


# ─────────────────────────────
# BACKEND LAUNCH TEMPLATE
# Remains commented out
# ─────────────────────────────

# module "backend_launchtemplate" {
#   source = "../../modules/backend/launch-template"
#
#   aws_region   = var.aws_region
#   project_name = var.backend_lt_project_name
#
#   instance_type = var.backend_lt_instance_type
#   backend_sg_id = module.security.frontend_server_sg_id
#   key_name      = var.backend_lt_key_name
#
#   instanceid = module.backend-ec2.backend_instanceid
# }


# ─────────────────────────────
# BACKEND AUTO SCALING GROUP
# Remains commented out
# ─────────────────────────────

# module "asg-backend" {
#   source = "../../modules/backend/asg"
#
#   aws_region   = var.aws_region
#   project_name = var.backend_asg_project_name
#
#   backend_launch_template_id = module.backend_launchtemplate.backend_launch_template_id
#
#   app_subnet_1_id = module.vpc.private_app_subnets[0]
#   app_subnet_2_id = module.vpc.private_app_subnets[1]
#
#   backend_target_group_arn = module.backend_alb.alb_target_group_arn
#
#   backend_desired_capacity = var.backend_desired_capacity
#   backend_min_size         = var.backend_min_size
#   backend_max_size         = var.backend_max_size
#
#   scale_out_target_value = var.backend_scale_out_target_value
# }


# ─────────────────────────────
# FRONTEND AUTO SCALING GROUP
# Remains commented out
# ─────────────────────────────

# module "asg-frontend" {
#   source = "../../modules/frontend/asg"
#
#   aws_region   = var.aws_region
#   project_name = var.frontend_asg_project_name
#
#   frontend_launch_template_id = module.frontend_launchtemplate.frontend_launch_template_id
#
#   web_subnet_1_id = module.vpc.public_subnets[0]
#   web_subnet_2_id = module.vpc.public_subnets[1]
#
#   frontend_target_group_arn = module.frontend_alb.alb_target_group_arn
#
#   frontend_desired_capacity = var.frontend_desired_capacity
#   frontend_min_size         = var.frontend_min_size
#   frontend_max_size         = var.frontend_max_size
#
#   scale_out_target_value = var.frontend_scale_out_target_value
# }


# ─────────────────────────────
# ACM
# ─────────────────────────────

# module "acm" {
#   source = "../../modules/dns-delivery/acm"

#   certificate_name = var.certificate_name
#   domain_name      = var.domain_name

#   subject_alternative_names = var.subject_alternative_names

#   route53_zone_id = var.route53_zone_id
# }


# ─────────────────────────────
# CLOUDFRONT
# ─────────────────────────────

# module "cloudfront" {
#   source = "../../modules/dns-delivery/cloudfront"

#   distribution_comment = var.distribution_comment

#   origin_domain_name = module.frontend_alb.alb_dns_name

#   acm_certificate_arn = module.acm.certificate_arn

#   domain_names = var.domain_names
# }


# # ─────────────────────────────
# # ROUTE 53
# # ─────────────────────────────

# module "route53" {
#   source = "../../modules/dns-delivery/route53"

#   route53_zone_id = var.route53_zone_id

#   domain_names = var.domain_names

#   cloudfront_domain_name    = module.cloudfront.distribution_domain_name
#   cloudfront_hosted_zone_id = module.cloudfront.distribution_hosted_zone_id
# }























# ## Root module ##
# # ─────────────────────────────
# # VPC
# # ─────────────────────────────

# module "vpc" {
#   source   = "../../modules/networking"
# aws_region = "us-east-1"
# vpc_cidr = "10.0.0.0/16"
# vpc_name = "prod-vpc"
# public_subnet_1_cidr = "10.0.1.0/24"
# public_subnet_2_cidr = "10.0.2.0/24"
# private_subnet_1_cidr = "10.0.3.0/24"
# private_subnet_2_cidr = "10.0.4.0/24"
# private_subnet_3_cidr = "10.0.5.0/24"
# private_subnet_4_cidr = "10.0.6.0/24"
# private_subnet_5_cidr = "10.0.7.0/24"
# private_subnet_6_cidr = "10.0.8.0/24"
# availability_zone_1a = "us-east-1a"
# availability_zone_1b = "us-east-1b"
# }


# module "security" {
#   source = "../../modules/security"

#   vpc_id           = module.vpc.vpc_id
#   allowed_ssh_cidr =  ["0.0.0.0/0"] 
# }


# # ────────────────────────────
# # frontend ec2 instance public
# # ─────────────────────────────
# module "frontend-ec2" {
# source = "../../modules/frontend/ec2"
# aws_region = "us-east-1"
# ami = "ami-04b938437b69a2c9c"
# instance_type = "t2.medium"
# key_name = "us-east-1"
# subnet_id = module.vpc.public_subnets[0]
# security_group_id = module.security.bastion_host_sg_id

# }

# # ────────────────────────────
# # backend ec2 instance public
# # ─────────────────────────────
# module "backend-ec2" {
# source = "../../modules/backend/ec2"
# aws_region = "us-east-1"
# ami = "ami-04b938437b69a2c9c"
# instance_type = "t2.micro"
# key_name = "us-east-1"
# subnet_id = module.vpc.public_subnets[0]
# security_group_id = module.security.bastion_host_sg_id

# }
# # ────────────────────────────
# # AWS Bastion Host
# # ─────────────────────────────
# module "bastion" {
# source = "../../modules/bastion"
# aws_region = "us-east-1"
# ami = "ami-04b938437b69a2c9c"
# instance_type = "t2.micro"
# key_name = "us-east-1"
# subnet_id = module.vpc.public_subnets[0]
# security_group_id = module.security.bastion_host_sg_id

# }

# # ─────────────────────────────
# # Frontend ALB
# # ─────────────────────────────
# module "frontend_alb" {
# source = "../../modules/frontend/loadbalancer"
# aws_region = "us-east-1"
# vpc_id = module.vpc.vpc_id
# subnets = module.vpc.public_subnets
# security_group_id = module.security.alb_frontend_sg_id
# alb_name = "frontend-alb"
# target_group_name = "frontend-tg"
# certificate_arn = module.acm.certificate_arn

# }

# # ─────────────────────────────
# # Backend ALB
# # ─────────────────────────────
# module "backend_alb" {
# source = "../../modules/backend/loadbalancer"
# aws_region = "us-east-1"
# vpc_id = module.vpc.vpc_id
# subnets = module.vpc.public_subnets
# security_group_id = module.security.alb_backend_sg_id
# alb_name = "backend-alb"
# target_group_name = "backend-tg"
# }


# # ─────────────────────────────
# # RDS (DB Tier)
# # ─────────────────────────────
# module "rds" {
# source         = "../../modules/database"
# aws_region   = "us-east-1"
# project_name = "three-tier"
# identifier   = "book-rds"
# allocated_storage = 20
# engine            = "mysql"
# engine_version    = "8.0"
# instance_class    = "db.t3.micro"
# multi_az          = false
# db_name           = "bookdb"
# db_username       = "admin"
# db_password       = "shoaib123"
# db_subnet_1_id    = module.vpc.private_db_subnets[0]
# db_subnet_2_id    = module.vpc.private_db_subnets[1]
# rds_sg_id         = module.security.database_sg_id

# }



# # # ─────────────────────────────
# # # Frontend Launch Template
# # # ─────────────────────────────
# # module "frontend_launchtemplate" {

# # source        = "../../modules/frontend/launch-template"
# # #source = "../../modules/frontend/launch-template"
# # aws_region   = "us-east-1"
# # project_name   = "three-tier"
# # #frontend_ami   = module.frontend_launchtemplate.ami.id
# # instance_type  = "t3.micro"
# # frontend_sg_id = module.security.backend_server_sg_id
# # key_name       = "us-east-1"
# # instanceid = module.frontend-ec2.frontend_instanceid

# # }
# # # ─────────────────────────────
# # # Backend Launch Template
# # # ─────────────────────────────
# # module "backend_launchtemplate" {

# # source        = "../../modules/backend/launch-template"
# # #source = "../../modules/backend/launch-template"
# # aws_region   = "us-east-1"
# # project_name   = "three-tier"
# # #backend_ami    = module.backend_launchtemplate.ami.id
# # instance_type  = "t3.micro"
# # backend_sg_id  = module.security.frontend_server_sg_id
# # key_name       = "us-east-1"
# # instanceid = module.backend-ec2.backend_instanceid

# # }

# # # ────────────────────────────
# # # Auto Scaling Group backend
# # # ─────────────────────────────

# # module "asg-backend" {
# # source     = "../../modules/backend/asg"
# # #source = "../../modules/backend/asg"
# # aws_region = "us-east-1"
# # project_name = "books-three-tier"


# # # Backend
# # backend_launch_template_id = module.backend_launchtemplate.backend_launch_template_id
# # app_subnet_1_id            = module.vpc.private_app_subnets[0]
# # app_subnet_2_id            = module.vpc.private_app_subnets[1]
# # backend_target_group_arn   = module.backend_alb.alb_target_group_arn
# # backend_desired_capacity = 1
# # backend_min_size         = 1
# # backend_max_size         = 3
# # # Scaling
# # scale_out_target_value = 80

# # }

# # # ────────────────────────────
# # # Auto Scaling Group frontend
# # # ─────────────────────────────

# # module "asg-frontend" {
# # source     = "../../modules/frontend/asg"
# # # source = "../../modules/frontend/asg"
# # aws_region = "us-east-1"
# # project_name = "books-three-tier"

# # # Frontend
# # frontend_launch_template_id = module.frontend_launchtemplate.frontend_launch_template_id
# # web_subnet_1_id             = module.vpc.public_subnets[0]
# # web_subnet_2_id             = module.vpc.public_subnets[1]
# # frontend_target_group_arn   = module.frontend_alb.alb_target_group_arn

# # frontend_desired_capacity = 1
# # frontend_min_size         = 1
# # frontend_max_size         = 3

# # # Scaling
# # scale_out_target_value = 80

# # }


# //ACM

# module "acm" {
#   source = "../../modules/dns-delivery/acm"

#   certificate_name = "three-tier-certificate"

#   domain_name = "992382432902.realhandsonlabs.net"

#   subject_alternative_names = [
#     "www.992382432902.realhandsonlabs.net"
#   ]

#   route53_zone_id = "Z0825265EO9UMFHBELIS"
# }

# # CF
# module "cloudfront" {
#   source = "../../modules/dns-delivery/cloudfront"

#   distribution_comment = "three-tier-cloudfront"

#   origin_domain_name = module.frontend_alb.alb_dns_name

#   acm_certificate_arn = module.acm.certificate_arn

#   domain_names = [
#     "992382432902.realhandsonlabs.net",
#     "www.992382432902.realhandsonlabs.net"
#   ]
# }

# //route53
# module "route53" {
#   source = "../../modules/dns-delivery/route53"

#   route53_zone_id = "Z0825265EO9UMFHBELIS"

#   domain_names = [
#     "992382432902.realhandsonlabs.net",
#     "www.992382432902.realhandsonlabs.net"
#   ]

#   cloudfront_domain_name     = module.cloudfront.distribution_domain_name
#   cloudfront_hosted_zone_id  = module.cloudfront.distribution_hosted_zone_id
# }


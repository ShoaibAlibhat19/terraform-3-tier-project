variable "distribution_comment" {
  description = "Description of the CloudFront distribution"
  type        = string
}

variable "origin_domain_name" {
  description = "DNS name of the frontend ALB"
  type        = string
}

variable "acm_certificate_arn" {
  description = "ACM certificate ARN in us-east-1"
  type        = string
}

variable "domain_names" {
  description = "Custom domain names associated with CloudFront"
  type        = list(string)
}


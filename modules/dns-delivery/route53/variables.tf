variable "route53_zone_id" {
  description = "ID of the existing Route 53 hosted zone"
  type        = string
}

variable "domain_names" {
  description = "Domain names to point to CloudFront"
  type        = list(string)
}

variable "cloudfront_domain_name" {
  description = "Domain name of the CloudFront distribution"
  type        = string
}

variable "cloudfront_hosted_zone_id" {
  description = "CloudFront distribution hosted zone ID"
  type        = string
}


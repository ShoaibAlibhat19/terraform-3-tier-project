output "domain_record_fqdns" {
  description = "Fully qualified domain names of the CloudFront alias records"
  value       = [for record in aws_route53_record.cloudfront_alias : record.fqdn]
}

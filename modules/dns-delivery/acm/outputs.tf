output "certificate_arn" {
  description = "ARN of the validated ACM certificate"
  value       = aws_acm_certificate_validation.this.certificate_arn
}

output "certificate_domain_name" {
  description = "Primary domain name"
  value       = aws_acm_certificate.this.domain_name
}

output "certificate_status" {
  description = "Current ACM certificate status"
  value       = aws_acm_certificate.this.status
}


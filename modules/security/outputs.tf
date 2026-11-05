output "bastion_host_sg_id" {
  value = aws_security_group.bastion_host.id
}

output "alb_frontend_sg_id" {
  value = aws_security_group.alb_frontend.id
}

output "alb_backend_sg_id" {
  value = aws_security_group.alb_backend.id
}

output "frontend_server_sg_id" {
  value = aws_security_group.frontend_server.id
}

output "backend_server_sg_id" {
  value = aws_security_group.backend_server.id
}

output "database_sg_id" {
  value = aws_security_group.database.id
}


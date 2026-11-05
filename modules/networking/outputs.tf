output "vpc_id" {
  value = aws_vpc.three_tier.id
}

output "public_subnets" {
  value = [aws_subnet.pub1.id, aws_subnet.pub2.id]
}

output "private_web_subnets" {
  value = [aws_subnet.prvt3.id, aws_subnet.prvt4.id]
}

output "private_app_subnets" {
  value = [aws_subnet.prvt5.id, aws_subnet.prvt6.id]
}

output "private_db_subnets" {
  value = [aws_subnet.prvt7.id, aws_subnet.prvt8.id]
}
output "nat_gateway_id" {
  value = aws_nat_gateway.nat.id
}
output "frontend_public_ips" {
  value = aws_instance.frontend_nodes[*].public_ip
}

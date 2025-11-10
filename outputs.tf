output "vpc_id" {
  value = module.network.vpc_id
}

output "frontend_ips" {
  value = module.compute.frontend_public_ips
}

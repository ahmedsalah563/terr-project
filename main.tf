module "network" {
  source          = "./modules/network"
  vpc_cidr        = "10.10.0.0/16"
  public_subnets  = ["10.10.1.0/24", "10.10.2.0/24"]
  private_subnets = ["10.10.3.0/24", "10.10.4.0/24"]
  azs             = ["us-east-1a", "us-east-1b"]
}

module "compute" {
  source          = "./modules/compute"
  public_subnets  = module.network.public_subnet_ids
  private_subnets = module.network.private_subnet_ids
  key_name        = "devops-key"
}

module "loadbalancer" {
  source          = "./modules/loadbalancer"
  public_subnets  = module.network.public_subnet_ids
  private_subnets = module.network.private_subnet_ids
}

resource "null_resource" "export_ips" {
  provisioner "local-exec" {
    command = <<EOT
echo "frontend-1 ${module.compute.frontend_public_ips[0]}" > all-ips.txt
echo "frontend-2 ${module.compute.frontend_public_ips[1]}" >> all-ips.txt
EOT
  }
}

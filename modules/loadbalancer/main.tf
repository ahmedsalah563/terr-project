resource "aws_lb" "public_lb" {
  name               = "frontend-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = var.public_subnets
  tags = { Name = "frontend-alb" }
}

resource "aws_lb" "internal_lb" {
  name               = "app-alb"
  internal           = true
  load_balancer_type = "application"
  subnets            = var.private_subnets
  tags = { Name = "app-alb" }
}

output "public_alb_arn" {
  value = aws_lb.public_lb.arn
}

output "internal_alb_arn" {
  value = aws_lb.internal_lb.arn
}
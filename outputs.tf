
output "alb_dns" {
  value = aws_lb.alb.dns_name
}

output "drupal_domain" {
  value = var.Route53RecordName
}


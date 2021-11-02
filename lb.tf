resource "aws_lb" "alb" {
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = aws_subnet.public_subnets.*.id

  #   idle_timeout = var.LBTimeOut
  #   ip_address_type = var.private_mode ? "ipv4" : "dualstack"

  tags = { Name : "Drupal-Load_Balancer" }

}
resource "aws_lb_target_group" "alb_targets" {
  name_prefix = "drp-lb"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.vpc.id
  #   deregistration_delay = 30
  target_type = "instance"

  health_check {
    enabled             = true
    interval            = 30
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 5
    # matcher             = "200"
  }

  tags = { Name : "drupal-lb-target-group" }


}
resource "aws_lb_listener" "alb_http" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 443
  protocol          = "HTTP"
  #   ssl_policy = "ELBSecurityPolicy-FS-2018-06" // Enable Forward Secrecy
  #   certificate_arn = data.aws_acm_certificate.vault_alb_cert.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_targets.arn
  }
}

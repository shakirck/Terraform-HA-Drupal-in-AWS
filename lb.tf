resource "aws_lb" "alb" {
  name = "drupal-lb-tf"

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
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-FS-2018-06"
  certificate_arn   = data.aws_acm_certificate.drupal.arn


  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_targets.arn
  }
}

resource "aws_lb_listener" "alb_http_redirect" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"


  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_targets.arn
  }
}

# resource "aws_lb_cookie_stickiness_policy" "drupal" {
#   name                     = "boom"
#   load_balancer            = aws_lb.alb.name
#   lb_port                  = 80
#   cookie_expiration_period = 300000
# }

# resource "aws_lb_cookie_stickiness_policy" "drupalhttps" {
#   name                     = "boom"
#   load_balancer            = aws_lb.alb.name
#   lb_port                  = 443
#   cookie_expiration_period = 300000
# }



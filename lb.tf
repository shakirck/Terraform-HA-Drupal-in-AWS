resource "aws_lb" "alb" {
  name = var.LoadBalancerName

  internal           = false
  load_balancer_type = var.LoadBalancerType
  security_groups    = [aws_security_group.alb.id]
  subnets            = aws_subnet.public_subnets.*.id

  #   idle_timeout = var.LBTimeOut
  #   ip_address_type = var.private_mode ? "ipv4" : "dualstack"
  tags = { Name : "Drupal-Load_Balancer" }

}
resource "aws_lb_target_group" "alb_targets" {
  name_prefix = var.AlbTargetNamePrefix
  port        = var.AlbPort
  protocol    = var.AlbProtocol
  vpc_id      = aws_vpc.vpc.id
  #   deregistration_delay = 30
  target_type = var.AlbTargetType

  health_check {
    enabled             = true
    interval            = var.AlbHealthCheckInterval
    protocol            = var.AlbHealthCheckProtocol
    timeout             = var.AlbHealthCheckTimeout
    healthy_threshold   = var.AlbHealthyThreshold
    unhealthy_threshold = var.AlbUnhealthyThreshold
    # matcher             = "200"
  }
  stickiness {
    type        = var.AlbSticknessType
    enabled     = var.EnableAlbStickiness
    cookie_name = var.AlbStickinessCookieName
  }


  tags = var.AlbTargetTags


}
resource "aws_lb_listener" "alb_http" {
  load_balancer_arn = aws_lb.alb.arn
  port              = var.AlbListenerHttpsPort
  protocol          = var.AlbListenerHttpsProtocol
  ssl_policy        = var.AlbListenerHttpsSslPolicy
  certificate_arn   = data.aws_acm_certificate.drupal.arn


  default_action {
    type             = var.AlbListenerDefaultAction
    target_group_arn = aws_lb_target_group.alb_targets.arn
  }
}

resource "aws_lb_listener" "alb_http_redirect" {
  load_balancer_arn = aws_lb.alb.arn
  port              = var.AlbListenerHttpPort
  protocol          = var.AlbListenerHttpProtocol


  default_action {
    type             = var.AlbListenerDefaultAction
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



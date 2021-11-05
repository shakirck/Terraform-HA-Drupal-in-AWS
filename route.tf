data "aws_route53_zone" "selected" {
  name = "hyremaster.com"
}
resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = "login.hyremaster.com"
  type    = "CNAME"
  ttl     = "300"
  records = [aws_lb.alb.dns_name]
}

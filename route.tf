data "aws_route53_zone" "selected" {
  name = var.HostedZoneName
}
resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = var.Route53RecordName
  type    = var.Route53RecordType
  ttl     = var.Route53RecordTTL
  records = [aws_lb.alb.dns_name]
}

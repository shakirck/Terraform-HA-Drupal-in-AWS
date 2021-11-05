data "aws_acm_certificate" "drupal" {
  #   provider = aws.acm
  domain   = "login.hyremaster.com"
  statuses = ["ISSUED"]
}

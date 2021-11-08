data "aws_acm_certificate" "drupal" {
  domain   = var.AcmCertDomain
  statuses = var.AcmCertStatuses
}

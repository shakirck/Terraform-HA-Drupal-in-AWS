
data "aws_ami" "bitnami" {
  owners      = var.DrupalAmiOwner
  most_recent = true
  filter {
    name = "name"
    values = var.FilterNameValues
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
output "bitnami_ami" {
  value = data.aws_ami.bitnami.image_id
}

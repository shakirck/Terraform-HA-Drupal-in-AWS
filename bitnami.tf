
data "aws_ami" "bitnami" {
  owners      = ["679593333241"]
  most_recent = true
  filter {
    name = "name"
    # values = ["bitnami-drupal-*"] bitnami-drupal-9.2.6-0-
    values = ["bitnami-drupal-9.2.6-0-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
# ami-0e95dccb19d5d624a
output "bitnami_ami" {
  value = data.aws_ami.bitnami.image_id
}
# data "aws_ami" "ubuntu" {
#   most_recent = true

#   filter {
#     name   = "name"
#     values = ["CIS Ubuntu Linux 18.04 LTS Benchmark v1.0.0.* - Level 1-*"]
#   }

#   filter {
#     name   = "virtualization-type"
#     values = ["hvm"]
#   }

#   owners =["679593333241"]
# }

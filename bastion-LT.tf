resource "aws_launch_template" "bastion" {
  image_id      = data.aws_ami.amazon_linux2.id
  instance_type = var.BastionInstanceType
  user_data     = ""
  key_name      = var.KeyPairName
  network_interfaces {
    security_groups = [aws_security_group.bastion.id]
    associate_public_ip_address = true
  }
  tag_specifications {
    resource_type = var.BastionLTResourceType
    tags = {
      Name = var.BastionInstanceTagValue
    }
  }
  tags = {
    Name : var.BastionLaunchTemplateName,
    Project : var.ProjectName,
  }
}
data "aws_ami" "amazon_linux2" {
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }
  owners = ["amazon"]
}

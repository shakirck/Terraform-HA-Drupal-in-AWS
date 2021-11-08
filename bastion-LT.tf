resource "aws_launch_template" "bastion" {
  image_id      = data.aws_ami.latest-ubuntu.id
  instance_type = var.BastionInstanceType
  user_data     = ""
  key_name      = var.KeyPairName
  network_interfaces {
    security_groups = [aws_security_group.bastion.id]


    associate_public_ip_address = true
  }
  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "bastion"
    }
  }


  tags = {

    Name : "drupal- basiton-lt",

    Project : "drupal"

  }


}
data "aws_ami" "latest-ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

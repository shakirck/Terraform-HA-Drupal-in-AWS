resource "aws_launch_template" "webserver" {
  image_id      = data.aws_ami.bitnami.id
  instance_type = "t2.micro"
  user_data     = base64encode(data.template_file.user_data_file.rendered)


  key_name = var.KeyPairName
  network_interfaces {
    security_groups = [aws_security_group.webserver.id]


    associate_public_ip_address = true
  }



  iam_instance_profile {
    name = aws_iam_instance_profile.main_drupal.name
  }

  depends_on = [
    aws_efs_file_system.efs, aws_efs_mount_target.efs-mt
  ]


  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "Webserver"
    }
  }

  tags = {

    Name : "drupal-webserver-lt",

    Project : "drupal"

  }


}


data "template_file" "user_data_file" {
  template = file("ec2.tpl")

  vars = {
    fsid = "${aws_efs_file_system.efs.id}"
  }

}


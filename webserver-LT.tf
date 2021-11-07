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
    aws_efs_file_system.efs,
    aws_efs_mount_target.efs-mt,
    aws_rds_cluster.default,
    aws_rds_cluster_instance.cluster_instances
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
    fsid1       = "${aws_efs_file_system.efs.id}"
    fsid2       = "NOT NEEDED FOR NOW TO BE REMOVED LATER"
    DB_NAME     = "bitnami_drupal"
    DB_USERNAME = "dbadmin"
    DB_PASSWORD = "12345678"
    DB_HOST     = "${aws_rds_cluster.default.endpoint}"
  }
  depends_on = [
    aws_efs_file_system.efs,
    aws_rds_cluster.default,
    aws_rds_cluster_instance.cluster_instances
  ]

}


resource "aws_launch_template" "webserver" {
  image_id      = data.aws_ami.bitnami.id
  instance_type = var.WebServerInstanceType
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
    tags = var.WebServerInstanceTags
  }
  tags = var.WebServerASGTags
}


data "template_file" "user_data_file" {
  template = file("ec2.tpl")
  vars = {
    fsid1       = "${aws_efs_file_system.efs.id}"
    fsid2       = " "
    DB_NAME     = var.RdsDatabaseName
    DB_USERNAME = var.RdsMasterUsername
    DB_PASSWORD = var.RdsMasterPassword
    DB_HOST     = "${aws_rds_cluster.default.endpoint}"
  }
  depends_on = [
    aws_efs_file_system.efs,
    aws_rds_cluster.default,
    aws_rds_cluster_instance.cluster_instances
  ]

}


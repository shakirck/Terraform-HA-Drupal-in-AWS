resource "aws_autoscaling_group" "webserver" {
  name_prefix = " webserver-asg"
  launch_template {
    id      = aws_launch_template.webserver.id
    version = aws_launch_template.webserver.latest_version
  }


  # All the same to keep at a fixed size
  desired_capacity = var.max
  min_size         = var.max
  max_size         = var.max

  # AKA the subnets to launch resources in 
  vpc_zone_identifier = aws_subnet.private_subnets.*.id

  health_check_grace_period = 300
  health_check_type         = "EC2"
  termination_policies      = ["OldestLaunchTemplate"]
  wait_for_capacity_timeout = 0

  target_group_arns = [aws_lb_target_group.alb_targets.arn]
  depends_on = [
    aws_efs_file_system.efs, aws_efs_mount_target.efs-mt
  ]

  tags = [{
    Name : "webserver"
  }]
}

resource "aws_autoscaling_group" "webserver" {
  name_prefix = " webserver-asg"
  launch_template {
    id      = aws_launch_template.webserver.id
    version = aws_launch_template.webserver.latest_version
  }


  # All the same to keep at a fixed size
  desired_capacity = var.DesiredInstanceCapacity
  min_size         = var.MinInstances
  max_size         = var.MaxInstances

  # AKA the subnets to launch resources in 
  vpc_zone_identifier = aws_subnet.private_subnets.*.id

  health_check_grace_period = var.InstanceHealthCheckGracePeriod
  health_check_type         = var.InstanceHealthCheckType
  termination_policies      = var.InstanceTerminaitonPolicies
  wait_for_capacity_timeout = var.InstanceHealthCheckTimeout

  target_group_arns = [aws_lb_target_group.alb_targets.arn]
  depends_on = [
    aws_efs_file_system.efs, aws_efs_mount_target.efs-mt
  ]

  tags = [{
    Name : "webserver"
  }]
}

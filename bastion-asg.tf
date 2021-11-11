resource "aws_autoscaling_group" "bastion" {
  name_prefix = var.BastionAsgNamePrefix
  launch_template {
    id      = aws_launch_template.bastion.id
    version = aws_launch_template.bastion.latest_version
  }
  # All the same to keep at a fixed size
  desired_capacity = var.BastionCount
  min_size         = var.BastionCount
  max_size         = var.BastionCount
  vpc_zone_identifier = aws_subnet.public_subnets.*.id
  health_check_grace_period = var.BastionHealthCheckGracePeriod
  health_check_type         = var.BastionHealthCheckType
  termination_policies      = var.BastionTerminationPolicies
  wait_for_capacity_timeout = var.BastionWaitForCapacityTimeout
  tag {
    key                 = var.BastionASGTagKey
    value               = var.BastionASGTagValue
    propagate_at_launch = true
  }
}

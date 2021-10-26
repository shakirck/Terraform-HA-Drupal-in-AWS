resource "aws_autoscaling_group" "bastion" {
  name_prefix = " bastion-asg"

  launch_template {
    id      = aws_launch_template.bastion.id
    version = aws_launch_template.bastion.latest_version
  }


  # All the same to keep at a fixed size
  desired_capacity = var.max
  min_size         = var.max
  max_size         = var.max

  # AKA the subnets to launch resources in 
  vpc_zone_identifier = aws_subnet.public_subnets.*.id

  health_check_grace_period = 300
  health_check_type         = "EC2"
  termination_policies      = ["OldestLaunchTemplate"]
  wait_for_capacity_timeout = 0



  tags = [{
    Name : "Bastion"
  }]
}

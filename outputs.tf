
output "mount_terget_id" {
  value = aws_efs_mount_target.efs-mt.*.id
}

output "efsip" {
  value = {
    for mounttarget in aws_efs_mount_target.efs-mt :
    mounttarget.id => mounttarget.ip_address
  }
}

output "alb_dns" {
  value = aws_lb.alb.dns_name

}

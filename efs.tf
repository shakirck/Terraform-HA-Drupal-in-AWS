
resource "aws_efs_file_system" "efs" {
  creation_token   = var.EfsCreationToken
  performance_mode = var.EfsPerformanceMode
  encrypted        = var.IsEfsEncrypted
  tags = {
    Name = "LAMP EFS Shared Filesystem For Drupal"
  }

}

resource "aws_efs_mount_target" "efs-mt" {
  count           = var.max
  file_system_id  = aws_efs_file_system.efs.id
  subnet_id       = aws_subnet.private_subnets[count.index].id
  security_groups = [aws_security_group.efs.id]
  depends_on = [
    aws_efs_file_system.efs
  ]
}

resource "aws_efs_access_point" "efs-access-point" {
  file_system_id = aws_efs_file_system.efs.id

}



# resource "aws_efs_file_system" "efs2" {
#   creation_token   = "drupal-efs2"
#   performance_mode = "generalPurpose"
#   encrypted        = "true"
#   tags = {
#     Name = "LAMP EFS Shared Filesystem For Drupal2"
#   }

# }

# resource "aws_efs_mount_target" "efs2-mt" {
#   count           = var.max
#   file_system_id  = aws_efs_file_system.efs2.id
#   subnet_id       = aws_subnet.private_subnets[count.index].id
#   security_groups = [aws_security_group.efs.id]
#   depends_on = [
#     aws_efs_file_system.efs2
#   ]
# }

# resource "aws_efs_access_point" "efs2-access-point" {
#   file_system_id = aws_efs_file_system.efs2.id

# }


resource "aws_efs_file_system" "efs" {
  creation_token   = var.EfsCreationToken
  performance_mode = var.EfsPerformanceMode
  encrypted        = var.IsEfsEncrypted
  tags             = var.EfsFileTags
}

resource "aws_efs_mount_target" "efs-mt" {
  count           = var.MaxInstances
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

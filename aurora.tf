resource "aws_rds_cluster" "default" {
  cluster_identifier = var.RdsClusterIdentifier
  engine             = var.RdsEngine
  engine_version     = var.RdsEngineVersion
  availability_zones = var.RdsAvailabilityZones
  database_name      = var.RdsDatabaseName
  master_username    = var.RdsMasterUsername
  master_password    = var.RdsMasterPassword
  #   backup_retention_period = 0
  vpc_security_group_ids = [aws_security_group.aurora_rds.id]
  #   preferred_backup_window = "07:00-09:00"
  #   storage encrypted = true  
  skip_final_snapshot  = true
  apply_immediately    = true
  db_subnet_group_name = aws_db_subnet_group.default.name
}
resource "aws_rds_cluster_instance" "cluster_instances" {
  count                = var.RdsInstanceCount
  identifier           = "${var.RdsIntanceIdentifierPrefix}-${count.index}"
  cluster_identifier   = aws_rds_cluster.default.id
  instance_class       = var.RdsInstanceClass
  engine               = aws_rds_cluster.default.engine
  engine_version       = aws_rds_cluster.default.engine_version
  db_subnet_group_name = aws_db_subnet_group.default.name
}

resource "aws_db_subnet_group" "default" {
  name       = var.RdsSubnetGroupName
  subnet_ids = aws_subnet.private_subnets.*.id
  tags = {
    Description = var.RdsSubnetGroupTagDescription
  }
}

resource "aws_rds_cluster" "default" {
  cluster_identifier = "aurora-cluster-demo"
  engine             = "aurora-mysql"
  engine_version     = "5.7.mysql_aurora.2.03.2"
  availability_zones = ["us-east-1a", "us-east-1b"]
  database_name      = "mydb"
  master_username    = "dbadmin"
  master_password    = "12345678"
  #   backup_retention_period = 0
  vpc_security_group_ids = [aws_security_group.aurora_rds.id]
  #   preferred_backup_window = "07:00-09:00"
  #   storage encrypted
  # 
  skip_final_snapshot  = true
  apply_immediately    = true
  db_subnet_group_name = aws_db_subnet_group.default.name

}
resource "aws_rds_cluster_instance" "cluster_instances" {
  count                = var.max
  identifier           = "aurora-cluster-demo-${count.index}"
  cluster_identifier   = aws_rds_cluster.default.id
  instance_class       = "db.t2.small"
  engine               = aws_rds_cluster.default.engine
  engine_version       = aws_rds_cluster.default.engine_version
  db_subnet_group_name = aws_db_subnet_group.default.name
}

resource "aws_db_subnet_group" "default" {
  name       = "aurora-drupal-subnet-group"
  subnet_ids = aws_subnet.private_subnets.*.id

  tags = {
    Name = "My DB subnet group"
  }
}

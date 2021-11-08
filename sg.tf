# Bastion
resource "aws_security_group" "bastion" {
  name_prefix = "bastion-sg"
  description = "Firewall for the operator bastion instance"
  vpc_id      = aws_vpc.vpc.id

}
resource "aws_security_group_rule" "bastion_ssh_ingress" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = var.BastionIngressCIDR
  security_group_id = aws_security_group.bastion.id
}
resource "aws_security_group_rule" "bastion_allow_outbound" {
  security_group_id = aws_security_group.bastion.id
  type              = "egress"
  protocol          = "-1"
  from_port         = -1
  to_port           = -1
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Allow any outbound traffic."
}

#webserver 

resource "aws_security_group" "webserver" {
  name_prefix = "webserver-sg"
  description = "App Server Security Group"
  vpc_id      = aws_vpc.vpc.id

}

resource "aws_security_group_rule" "webserver" {
  security_group_id        = aws_security_group.webserver.id
  type                     = "ingress"
  protocol                 = "tcp"
  from_port                = 22
  to_port                  = 22
  source_security_group_id = aws_security_group.bastion.id
}
resource "aws_security_group_rule" "webserverssh" {
  security_group_id = aws_security_group.webserver.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 443
  to_port           = 443
  cidr_blocks       = ["0.0.0.0/0"]
}
resource "aws_security_group_rule" "webserver80" {
  security_group_id = aws_security_group.webserver.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 80
  to_port           = 80
  cidr_blocks       = ["0.0.0.0/0"]

}
resource "aws_security_group_rule" "webserveregress80" {
  security_group_id = aws_security_group.webserver.id
  type              = "egress"
  protocol          = "tcp"
  from_port         = 80
  to_port           = 80
  cidr_blocks       = ["0.0.0.0/0"]

}
resource "aws_security_group_rule" "webserveregress443" {
  security_group_id = aws_security_group.webserver.id
  type              = "egress"
  protocol          = "tcp"
  from_port         = 443
  to_port           = 443
  cidr_blocks       = ["0.0.0.0/0"]


}
resource "aws_security_group_rule" "efs-nfs-egress" {
  security_group_id        = aws_security_group.webserver.id
  type                     = "egress"
  protocol                 = "tcp"
  from_port                = 2049
  to_port                  = 2049
  source_security_group_id = aws_security_group.efs.id

}
resource "aws_security_group_rule" "webserver-aurora-egress" {
  security_group_id        = aws_security_group.webserver.id
  type                     = "egress"
  protocol                 = "tcp"
  from_port                = 3306
  to_port                  = 3306
  source_security_group_id = aws_security_group.aurora_rds.id
}
# EFS
resource "aws_security_group" "efs" {
  name_prefix = "efs-sg"
  description = "EFS Security Group"
  vpc_id      = aws_vpc.vpc.id
}

resource "aws_security_group_rule" "efs-nfs-ingress" {
  security_group_id        = aws_security_group.efs.id
  type                     = "ingress"
  protocol                 = "tcp"
  from_port                = 2049
  to_port                  = 2049
  source_security_group_id = aws_security_group.webserver.id
}

# Aurora
resource "aws_security_group" "aurora_rds" {
  name_prefix = "aurora-rds-sg"
  description = "Aurora Security Group"
  vpc_id      = aws_vpc.vpc.id
}
resource "aws_security_group_rule" "aurora-ingress" {
  security_group_id        = aws_security_group.aurora_rds.id
  type                     = "ingress"
  protocol                 = "tcp"
  from_port                = 3306
  to_port                  = 3306
  source_security_group_id = aws_security_group.webserver.id
}

# load balacner
resource "aws_security_group" "alb" {
  name_prefix = "alb-sg"
  description = "ALB Security Group"
  vpc_id      = aws_vpc.vpc.id
}
resource "aws_security_group_rule" "alb_ingress_80" {
  security_group_id = aws_security_group.alb.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 80
  to_port           = 80
  cidr_blocks       = ["0.0.0.0/0"]
}
resource "aws_security_group_rule" "alb_ingress_443" {
  security_group_id = aws_security_group.alb.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 443
  to_port           = 443
  cidr_blocks       = ["0.0.0.0/0"]
}
resource "aws_security_group_rule" "alb_egress_80" {
  security_group_id        = aws_security_group.alb.id
  type                     = "egress"
  protocol                 = "tcp"
  from_port                = 80
  to_port                  = 80
  source_security_group_id = aws_security_group.webserver.id
}


resource "aws_security_group_rule" "alb_egress_443" {
  security_group_id        = aws_security_group.alb.id
  type                     = "ingress"
  protocol                 = "tcp"
  from_port                = 443
  to_port                  = 443
  source_security_group_id = aws_security_group.webserver.id
}


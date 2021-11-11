# Bastion
resource "aws_security_group" "bastion" {
  name_prefix = var.BastionSecurityGroupNamePrefix
  description = var.BastionSecurityGroupDescription
  vpc_id      = aws_vpc.vpc.id

}
resource "aws_security_group_rule" "bastion_ssh_ingress" {
  type              = "ingress"
  from_port         = var.BastionIngressFromPort
  to_port           = var.BastionIngressToPort
  protocol          = var.BastionIngressProtocol
  cidr_blocks       = var.BastionIngressCIDR
  security_group_id = aws_security_group.bastion.id
}
resource "aws_security_group_rule" "bastion_allow_outbound" {
  security_group_id = aws_security_group.bastion.id
  type              = "egress"
  protocol          = var.BastionEgressProtocol
  from_port         = var.BastionEgressFromPort
  to_port           = var.BastionEgressFromPort
  cidr_blocks       = var.BastionEgressCIDR
  description       = var.BastionEgressDescription
}

#webserver 

resource "aws_security_group" "webserver" {
  name_prefix = var.WebServerSecurityGroupNamePrefix
  description = var.WebServerSecurityGroupDescription
  vpc_id      = aws_vpc.vpc.id

}

resource "aws_security_group_rule" "webserverssh" {
  security_group_id        = aws_security_group.webserver.id
  type                     = "ingress"
  protocol                 = var.WebServerSSHIngressProtocol
  from_port                = var.WebServerSSHIngressFromPort
  to_port                  = var.WebServerSSHIngressToPort
  source_security_group_id = aws_security_group.bastion.id
}
resource "aws_security_group_rule" "webserver443" {
  security_group_id = aws_security_group.webserver.id
  type              = "ingress"
  protocol          = var.WebServer443IngressProtocol
  from_port         = var.WebServer443IngressFromPort
  to_port           = var.WebServer443IngressToPort
  # cidr_blocks       = ["0.0.0.0/0"]
  source_security_group_id = aws_security_group.alb.id
}
resource "aws_security_group_rule" "webserver80" {
  security_group_id = aws_security_group.webserver.id
  type              = "ingress"
  protocol          = var.WebServer80IngressProtocol
  from_port         = var.WebServer80IngressFromPort
  to_port           = var.WebServer80IngressToPort
  # cidr_blocks       = ["0.0.0.0/0"]
  source_security_group_id = aws_security_group.alb.id

}
resource "aws_security_group_rule" "webserveregress80" {
  security_group_id = aws_security_group.webserver.id
  type              = "egress"
  protocol          = var.WebServer80EgressProtocol
  from_port         = var.WebServer80EgressFromPort
  to_port           = var.WebServer80EgressToPort
  cidr_blocks       = var.WebServer80EgressCIDR

}
resource "aws_security_group_rule" "webserveregress443" {
  security_group_id = aws_security_group.webserver.id
  type              = "egress"
  protocol          = var.WebServer443EgressProtocol
  from_port         = var.WebServer443EgressFromPort
  to_port           = var.WebServer443EgressToPort
  cidr_blocks       = var.WebServer443EgressCIDR


}
resource "aws_security_group_rule" "efs-nfs-egress" {
  security_group_id        = aws_security_group.webserver.id
  type                     = "egress"
  protocol                 = var.WebServerEFSEgressProtocol
  from_port                = var.WebServerEFSEgressFromPort
  to_port                  = var.WebServerEFSEgressToPort
  source_security_group_id = aws_security_group.efs.id

}
resource "aws_security_group_rule" "webserver-aurora-egress" {
  security_group_id        = aws_security_group.webserver.id
  type                     = "egress"
  protocol                 = var.WebServerAuroraEgressProtocol
  from_port                = var.WebServerAuroraEgressFromPort
  to_port                  = var.WebServerAuroraEgressToPort
  source_security_group_id = aws_security_group.aurora_rds.id
}
# EFS
resource "aws_security_group" "efs" {
  name_prefix = var.EFSSecurityGroupNamePrefix
  description = var.EFSSecurityGroupDescription
  vpc_id      = aws_vpc.vpc.id
}

resource "aws_security_group_rule" "efs-nfs-ingress" {
  security_group_id        = aws_security_group.efs.id
  type                     = "ingress"
  protocol                 = var.EFSSecurityGroupIngressProtocol
  from_port                = var.EFSSecurityGroupIngressFromPort
  to_port                  = var.EFSSecurityGroupIngressToPort
  source_security_group_id = aws_security_group.webserver.id
}

# Aurora
resource "aws_security_group" "aurora_rds" {
  name_prefix = var.AuroraSecurityGroupNamePrefix
  description = var.AuroraSecurityGroupDescription
  vpc_id      = aws_vpc.vpc.id
}
resource "aws_security_group_rule" "aurora-ingress" {
  security_group_id        = aws_security_group.aurora_rds.id
  type                     = "ingress"
  protocol                 = var.AuroraSecurityGroupIngressProtocol
  from_port                = var.AuroraSecurityGroupIngressFromPort
  to_port                  = var.AuroraSecurityGroupIngressToPort
  source_security_group_id = aws_security_group.webserver.id
}

# load balacner
resource "aws_security_group" "alb" {
  name_prefix = var.ALBSecurityGroupNamePrefix
  description = var.ALBSecurityGroupDescription
  vpc_id      = aws_vpc.vpc.id
}
resource "aws_security_group_rule" "alb_ingress_80" {
  security_group_id = aws_security_group.alb.id
  type              = "ingress"
  protocol          = var.ALBSecurityGroup80IngressProtocol
  from_port         = var.ALBSecurityGroup80IngressFromPort
  to_port           = var.ALBSecurityGroup80IngressToPort
  cidr_blocks       = var.ALBSecurityGroup80IngressCIDR
}
resource "aws_security_group_rule" "alb_ingress_443" {
  security_group_id = aws_security_group.alb.id
  type              = "ingress"
  protocol          = var.ALBSecurityGroup443IngressProtocol
  from_port         = var.ALBSecurityGroup443IngressFromPort
  to_port           = var.ALBSecurityGroup443IngressToPort
  cidr_blocks       = var.ALBSecurityGroup443IngressCIDR
}
resource "aws_security_group_rule" "alb_egress_80" {
  security_group_id        = aws_security_group.alb.id
  type                     = "egress"
  protocol                 = var.ALBSecurityGroup80EgressProtocol
  from_port                = var.ALBSecurityGroup80EgressFromPort
  to_port                  = var.ALBSecurityGroup80EgressToPort
  source_security_group_id = aws_security_group.webserver.id
}


resource "aws_security_group_rule" "alb_egress_443" {
  security_group_id        = aws_security_group.alb.id
  type                     = "ingress"
  protocol                 = var.ALBSecurityGroup80EgressProtocol
  from_port                = var.ALBSecurityGroup80EgressFromPort
  to_port                  = var.ALBSecurityGroup80EgressToPort
  source_security_group_id = aws_security_group.webserver.id
}


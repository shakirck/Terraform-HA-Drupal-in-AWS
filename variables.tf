variable "ProjectName" {
  type = string
}
variable "BastionCount" {
  type = number
}
# Bastion
variable "BastionInstanceType" {
  type = string
}
variable "BastionAsgNamePrefix" {
  type = string
}
variable "BastionHealthCheckType" {
  type = string
}
variable "BastionTerminationPolicies" {
  type = list(string)
}
variable "BastionWaitForCapacityTimeout" {
  type = number
}
variable "BastionHealthCheckGracePeriod" {
  type = number
}
variable "BastionASGTagKey" {
  type = string
}
variable "BastionASGTagValue" {
  type = string
}
variable "BastionLTResourceType" {
  type = string
}
variable "BastionInstanceTagValue" {
  type = string
}
variable "BastionLaunchTemplateName" {
  type = string
}
# ACM
variable "AcmCertDomain" {
  type = string
}
variable "AcmCertStatuses" {
  type = list(string)
}

# Aurora
variable "RdsClusterIdentifier" {
  type = string
}
variable "RdsEngine" {
  type = string
}
variable "RdsEngineVersion" {
  type = string
}
variable "RdsAvailabilityZones" {
  type = list(string)
}
variable "RdsDatabaseName" {
  type = string
}
variable "RdsMasterUsername" {
  type = string
}
variable "RdsMasterPassword" {
  type = string
}

variable "RdsInstanceCount" {
  type = number
}
variable "RdsIntanceIdentifierPrefix" {
  type = string
}
variable "RdsInstanceClass" {
  type = string
}


variable "RdsSubnetGroupName" {
  type = string
}

variable "RdsSubnetGroupTagDescription" {
  type = string
}

# Bitnamiami
variable "DrupalAmiOwner" {
  type = list(string)
}
variable "FilterNameValues" {
  type = list(string)
}


# efs
variable "EfsCreationToken" {
  type = string
}
variable "EfsPerformanceMode" {
  type = string
}
variable "IsEfsEncrypted" {
  type = string
}
variable "EfsFileTags" {
  type = map(string)
}
#LB
variable "LoadBalancerName" {
  type = string
}

variable "LoadBalancerType" {
  type = string
}

variable "AlbTargetNamePrefix" {
  type = string
}

variable "AlbPort" {
  type = number
}
variable "AlbProtocol" {
  type = string
}
variable "AlbTargetType" {

  type = string
}
variable "AlbHealthCheckInterval" {
  type = number
}
variable "AlbHealthCheckTimeout" {
  type = number
}
variable "AlbHealthyThreshold" {
  type = number
}
variable "AlbUnhealthyThreshold" {
  type = number
}
variable "AlbHealthCheckProtocol" {
  type = string
}
variable "AlbSticknessType" {
  type = string
}
variable "AlbStickinessCookieName" {
  type = string
}
variable "EnableAlbStickiness" {
  type = bool
}

variable "AlbTargetTags" {
  type = map(string)
}
variable "AlbListenerHttpsPort" {
  type = number
}
variable "AlbListenerHttpsProtocol" {
  type = string
}
variable "AlbListenerHttpsSslPolicy" {
  type = string
}
variable "AlbListenerDefaultAction" {
  type = string
}

variable "AlbListenerHttpPort" {
  type = number
}
variable "AlbListenerHttpProtocol" {
  type = string
}





# Route
variable "HostedZoneName" {
  type = string
}

variable "Route53RecordName" {
  type = string
}
variable "Route53RecordType" {
  type = string
}
variable "Route53RecordTTL" {
  type = string
}



# security groups

variable "BastionIngressFromPort" {
  type = number
}
variable "BastionIngressToPort" {
  type = number
}
variable "BastionIngressProtocol" {
  type = string
}
variable "BastionSecurityGroupNamePrefix" {
  type = string
}
variable "BastionSecurityGroupDescription" {
  type = string
}

variable "BastionIngressCIDR" {
  type = list(string)
}

variable "BastionEgressFromPort" {
  type = number
}
variable "BastionEgressToPort" {
  type = number
}

variable "BastionEgressProtocol" {
  type = string
}

variable "BastionEgressCIDR" {
  type = list(string)
}
variable "BastionEgressDescription" {
  type = string
}

variable "WebServerSecurityGroupNamePrefix" {
  type = string
}
variable "WebServerSecurityGroupDescription" {
  type = string
}

variable "WebServerSSHIngressFromPort" {
  type = number
}
variable "WebServerSSHIngressToPort" {
  type = number
}
variable "WebServerSSHIngressProtocol" {
  type = string
}

variable "WebServer443IngressFromPort" {
  type = number
}
variable "WebServer443IngressToPort" {
  type = number
}
variable "WebServer443IngressProtocol" {
  type = string
}
variable "WebServer80IngressFromPort" {
  type = number
}
variable "WebServer80IngressToPort" {
  type = number
}
variable "WebServer80IngressProtocol" {
  type = string
}


variable "WebServer80EgressFromPort" {
  type = number
}
variable "WebServer80EgressToPort" {
  type = number
}
variable "WebServer80EgressProtocol" {
  type = string
}
variable "WebServer80EgressCIDR" {
  type = list(string)
}

variable "WebServer443EgressFromPort" {
  type = number
}
variable "WebServer443EgressToPort" {
  type = number
}
variable "WebServer443EgressProtocol" {
  type = string
}
variable "WebServer443EgressCIDR" {
  type = list(string)
}


variable "WebServerEFSEgressFromPort" {
  type = number
}
variable "WebServerEFSEgressToPort" {
  type = number
}
variable "WebServerEFSEgressProtocol" {
  type = string
}


variable "WebServerAuroraEgressFromPort" {
  type = number
}
variable "WebServerAuroraEgressToPort" {
  type = number
}
variable "WebServerAuroraEgressProtocol" {
  type = string
}

variable "EFSSecurityGroupNamePrefix" {
  type = string
}
variable "EFSSecurityGroupDescription" {
  type = string
}

variable "EFSSecurityGroupIngressFromPort" {
  type = number
}
variable "EFSSecurityGroupIngressToPort" {
  type = number
}
variable "EFSSecurityGroupIngressProtocol" {
  type = string
}


variable "AuroraSecurityGroupNamePrefix" {
  type = string
}
variable "AuroraSecurityGroupDescription" {
  type = string
}

variable "AuroraSecurityGroupIngressFromPort" {
  type = number
}
variable "AuroraSecurityGroupIngressToPort" {
  type = number
}
variable "AuroraSecurityGroupIngressProtocol" {
  type = string
}

variable "ALBSecurityGroupNamePrefix" {
  type = string
}
variable "ALBSecurityGroupDescription" {
  type = string
}

variable "ALBSecurityGroup80IngressFromPort" {
  type = number
}
variable "ALBSecurityGroup80IngressToPort" {
  type = number
}
variable "ALBSecurityGroup80IngressProtocol" {
  type = string
}
variable "ALBSecurityGroup80IngressCIDR" {
  type = list(string)
}
variable "ALBSecurityGroup443IngressFromPort" {
  type = number
}
variable "ALBSecurityGroup443IngressToPort" {
  type = number
}
variable "ALBSecurityGroup443IngressProtocol" {
  type = string
}
variable "ALBSecurityGroup443IngressCIDR" {
  type = list(string)
}

variable "ALBSecurityGroup80EgressFromPort" {
  type = number
}
variable "ALBSecurityGroup80EgressToPort" {
  type = number
}
variable "ALBSecurityGroup80EgressProtocol" {
  type = string
}



variable "ALBSecurityGroup443EgressFromPort" {
  type = number
}
variable "ALBSecurityGroup443EgressToPort" {
  type = number
}
variable "ALBSecurityGroup443EgressProtocol" {
  type = string
}



# vpc
variable "vpcCIDR" {
  type = string
}
variable "vpcInstanceTenancy" {
  type = string
}

variable "VPCEnableDnsSupport" {
  type = bool
}
variable "VPCEnableDnsHostnames" {
  type = bool
}
variable "VPCTags" {
  type = map(string)
}

# route tables
variable "PublicRouteTableCIDR" {
  type = string
}
variable "PublicRouteTableTags" {
  type = map(string)
}

variable "PrivateRouteTableCIDR" {
  type = string
}

variable "PrivateRouteTableTags" {
  type = map(string)
}
# internet gateway

variable "IGWTags" {
  type = map(string)
}

# Nat gateway
variable "NATGatewayTags" {
  type = map(string)
}
# Subnets

variable "PublicSubnetTags" {
  type = map(string)
}

variable "PrivateSubnetTags" {
  type = map(string)
}


# Webserver asg


variable "MaxInstances" {
  type = number
}
variable "MinInstances" {
  type = number
}
variable "DesiredInstanceCapacity" {
  type = number
}
variable "InstanceHealthCheckType" {
  type = string
}
variable "InstanceTerminaitonPolicies" {
  type = list(string)
}
variable "InstanceHealthCheckGracePeriod" {
  type = number
}
variable "InstanceHealthCheckTimeout" {
  type = number
}
variable "WebServerASGTagKey" {
  type = string
}
variable "WebServerASGTagValue" {
  type = string
}
variable "WebServerASGNamePrefix" {
  type = string
}

variable "WebServerInstanceType" {
  type = string
}
variable "WebServerInstanceTags" {
  type = map(string)
}
variable "WebServerASGTags" {
  type = map(string)
}
# common
variable "awsRegion" {

  type = string
}

variable "GenerateNewKeyPair" {
  type = bool
}
variable "KeyPairName" {
  type = string
}

# iam
variable "IAMRoleTags" {
  type = map(string)
}
variable "IAMRoleName" {
  type = string
}

variable "IAMInstanceProfileName" {
  type = string
}

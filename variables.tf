variable "BastionCount" {
  type = number
}
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



# SG
variable "BastionIngressCIDR" {
  type = list(string)
}



# vpc
variable "vpcCIDR" {
  type = string
}
variable "vpcInstanceTenancy" {
  type = string
}




# route tables
variable "PublicRouteTableCIDR" {
  type = string
}

variable "PrivateRouteTableCIDR" {
  type = string
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

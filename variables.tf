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





variable "max" {
  default = 2
}

variable "awsRegion" {
  default = "us-east-1"
}

variable "GenerateNewKeyPair" {
  default = true
}
variable "KeyPairName" {
  default = "drupal"
}

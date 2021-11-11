
data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_vpc" "vpc" {
  cidr_block           = var.vpcCIDR
  enable_dns_hostnames = var.VPCEnableDnsHostnames
  enable_dns_support   = var.VPCEnableDnsSupport
  instance_tenancy     = var.vpcInstanceTenancy
  tags                 = var.VPCTags
}


resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags   = var.IGWTags
}

resource "aws_subnet" "public_subnets" {
  vpc_id = aws_vpc.vpc.id
  count = var.MaxInstances
  cidr_block              = cidrsubnet(aws_vpc.vpc.cidr_block, 4, count.index)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true
  assign_ipv6_address_on_creation = false
  tags                            = var.PublicSubnetTags
}
resource "aws_subnet" "private_subnets" {
  vpc_id = aws_vpc.vpc.id
  count  = var.MaxInstances
  cidr_block        = cidrsubnet(aws_vpc.vpc.cidr_block, 4, count.index + var.MaxInstances)
  availability_zone = data.aws_availability_zones.available.names[count.index]
  tags              = var.PrivateSubnetTags
}

# route tables
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = var.PublicRouteTableCIDR # Traffic from Public Subnet reaches Internet via Internet Gateway
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = var.PublicRouteTableTags
}

resource "aws_route_table" "private_rt" {
  count  = var.MaxInstances
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = var.PrivateRouteTableCIDR
    gateway_id = aws_nat_gateway.main_nat[count.index].id
  }
  tags = var.PrivateRouteTableTags
}


resource "aws_eip" "nat_eip" {
  count = var.MaxInstances
  vpc   = true
  depends_on = [
    aws_internet_gateway.igw
  ]
}
resource "aws_nat_gateway" "main_nat" {
  count         = var.MaxInstances
  allocation_id = aws_eip.nat_eip[count.index].id
  subnet_id     = aws_subnet.public_subnets[count.index].id
  tags = var.NATGatewayTags
  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.igw]
}


resource "aws_route_table_association" "public_rta" {
  count          = var.MaxInstances
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.public_rt.id

}
resource "aws_route_table_association" "private_rta" {
  count          = var.MaxInstances
  subnet_id      = aws_subnet.private_subnets[count.index].id
  route_table_id = aws_route_table.private_rt[count.index].id
}

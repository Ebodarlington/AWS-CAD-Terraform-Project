provider "aws" {
  region = "ca-central-1"
}

# VPC
resource "aws_vpc" "custom_vpc" {
  cidr_block = "10.40.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "CustomVPC"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.custom_vpc.id
  tags = {
    Name = "CustomVPC-IGW"
  }
}

# Route Table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.custom_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "PublicRouteTable"
  }
}

# Subnets
resource "aws_subnet" "subnet1" {
  vpc_id                  = aws_vpc.custom_vpc.id
  cidr_block              = "10.40.1.0/24"
  availability_zone       = "ca-central-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "PublicSubnet-1"
  }
}

resource "aws_subnet" "subnet2" {
  vpc_id            = aws_vpc.custom_vpc.id
  cidr_block        = "10.40.2.0/24"
  availability_zone = "ca-central-1a"
  tags = {
    Name = "PrivateSubnet-2"
  }
}

resource "aws_subnet" "subnet3" {
  vpc_id                  = aws_vpc.custom_vpc.id
  cidr_block              = "10.40.3.0/24"
  availability_zone       = "ca-central-1b"
  map_public_ip_on_launch = true
  tags = {
    Name = "PublicSubnet-3"
  }
}

resource "aws_subnet" "subnet4" {
  vpc_id            = aws_vpc.custom_vpc.id
  cidr_block        = "10.40.4.0/24"
  availability_zone = "ca-central-1b"
  tags = {
    Name = "PrivateSubnet-4"
  }
}

# Route Table Associations (Public)
resource "aws_route_table_association" "rta_subnet1" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "rta_subnet3" {
  subnet_id      = aws_subnet.subnet3.id
  route_table_id = aws_route_table.public_rt.id
}

# Security Groups
resource "aws_security_group" "PublicEC2SG" {
  name        = "PublicEC2SG"
  description = "Allow SSH and HTTP"
  vpc_id      = aws_vpc.custom_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "PublicEC2SG"
  }
}

resource "aws_security_group" "PublicALBSG" {
  name        = "PublicALBSG"
  description = "Allow HTTP and HTTPS"
  vpc_id      = aws_vpc.custom_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "PublicALBSG"
  }
}

resource "aws_vpc" "nat" {
  cidr_block = "172.24.0.0/16"

  enable_dns_hostnames = true

  tags = {
    Name = "vpc-nat"
  }
}

resource "aws_subnet" "public-nat" {
  vpc_id = aws_vpc.nat.id

  cidr_block = "172.24.1.0/24"

  availability_zone = var.zones["a"]

  tags = {
    Name = "public-nat"
  }
}

resource "aws_subnet" "private-nat-1" {
  vpc_id = aws_vpc.nat.id

  cidr_block = "172.24.2.0/24"

  availability_zone = var.zones["a"]

  tags = {
    Name = "private-nat-1"
    "kubernetes.io/cluster/${var.cluster-name}" = "shared"
  }
}

resource "aws_subnet" "private-nat-2" {
  vpc_id = aws_vpc.nat.id

  cidr_block = "172.24.3.0/24"

  availability_zone = var.zones["b"]

  tags = {
    Name = "private-nat-2"
    "kubernetes.io/cluster/${var.cluster-name}" = "shared"
  }
}

resource "aws_internet_gateway" "nat" {
  vpc_id = aws_vpc.nat.id

  tags = {
    Name = "vpc-nat-igw"
  }
}

resource "aws_eip" "nat" {
  vpc = true

  tags = {
    Name = "public-nat-ip"
  }
}

resource "aws_nat_gateway" "public-nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public-nat.id

  tags = {
    Name = "publid-nat-gw"
  }
}

resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.nat.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.nat.id
  }

  tags = {
    Name = "public-nat-rt"
  }
}

resource "aws_route_table_association" "public-rt" {
  subnet_id = aws_subnet.public-nat.id
  route_table_id = aws_route_table.public-rt.id
}

resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.nat.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.public-nat.id
  }

  tags = {
    Name = "private-rt"
  }
}

resource "aws_route_table_association" "private-rt-1" {
  subnet_id = aws_subnet.private-nat-1.id
  route_table_id = aws_route_table.private-rt.id
}

resource "aws_route_table_association" "private-rt-2" {
  subnet_id = aws_subnet.private-nat-2.id
  route_table_id = aws_route_table.private-rt.id
}

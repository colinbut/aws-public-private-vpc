provider "aws" {
  region = "eu-west-2"
}

resource "aws_vpc" "VPC" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags = {
      Name = "public-private-vpc-VPC"
  }
}

resource "aws_internet_gateway" "public-private-vpc-IGW" {
  vpc_id = "${aws_vpc.VPC.id}"
  tags = {
      Name = "public-private-vpc-IGW"
  }
}

resource "aws_subnet" "public-subnet-A" {
  vpc_id = "${aws_vpc.VPC.id}"
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet-A"
  }
}

resource "aws_subnet" "public-subnet-B" {
  vpc_id = "${aws_vpc.VPC.id}"
  cidr_block = "10.0.2.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet-B"
  }
}

resource "aws_subnet" "private-subnet-A" {
  vpc_id = "${aws_vpc.VPC.id}"
  cidr_block = "10.0.3.0/24"
  tags = {
    Name = "private-subnet-A"
  }
}

resource "aws_subnet" "private-subnet-B" {
  vpc_id = "${aws_vpc.VPC.id}"
  cidr_block = "10.0.4.0/24"
  tags = {
    Name = "private-subnet-B"
  }
}

resource "aws_route_table" "public-route-table-A" {
  vpc_id = "${aws_vpc.VPC.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.public-private-vpc-IGW.id}"
  }

  tags = {
    Name = "PublicRouteTableA"
  }
}

resource "aws_route_table" "public-route-table-B" {
  vpc_id = "${aws_vpc.VPC.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.public-private-vpc-IGW.id}"
  }

  tags = {
    Name = "PublicRouteTableB"
  }
}

resource "aws_route_table_association" "public-route-table-association-A" {
  subnet_id = "${aws_subnet.public-subnet-A.id}"
  route_table_id = "${aws_route_table.public-route-table-A.id}"
}

resource "aws_route_table_association" "public-route-table-association-B" {
  subnet_id = "${aws_subnet.public-subnet-B.id}"
  route_table_id = "${aws_route_table.public-route-table-B.id}"
}

resource "aws_eip" "elastic_ip_address" {
  vpc = true
}

// Just one NAT GW associated to one subnet (public subnet A)
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = "${aws_eip.elastic_ip_address.id}"
  subnet_id = "${aws_subnet.public-subnet-A.id}"
  depends_on = ["aws_internet_gateway.public-private-vpc-IGW"]
}



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

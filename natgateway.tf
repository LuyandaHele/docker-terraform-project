# nat gateway allocating this elastic ip within the public subnet az1
resource "aws_eip" "eip_public_subnet_az1" {
  domain = "vpc"

  tags = {
    Name = "${var.project_name}-${var.environment}-eip-public-az1"
  }
}

# nat gateway allocating this elastic ip within the public subnet az2
resource "aws_eip" "eip_public_subnet_az2" {
  domain = "vpc"

  tags = {
    Name = "${var.project_name}-${var.environment}-eip-public-az2"
  }
}

# create nat gateway in public subnet az1
resource "aws_nat_gateway" "nat_gateway_az1" {
  allocation_id = aws_eip.eip_public_subnet_az1.id
  subnet_id     = aws_subnet.public_subnet_az1.id
  tags = {
    Name = "${var.project_name}-${var.environment}-nat-gateway-az1"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.internet_gateway]
}

# create nat gateway in public subnet az2
resource "aws_nat_gateway" "nat_gateway_az2" {
  allocation_id = aws_eip.eip_public_subnet_az2.id
  subnet_id     = aws_subnet.public_subnet_az2.id
  tags = {
    Name = "${var.project_name}-${var.environment}-nat-gateway-az2"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.internet_gateway]
}


#creating private route table az1 and adding the private route table through the nat gateway az1
resource "aws_route_table" "private_route_table_az1" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway_az1.id
  }

  tags = {
    Name = "${var.project_name}-${var.environment}-private-route-table-az1"
  }
}

#creating private route table az2 and adding the private route table through the nat gateway az2
resource "aws_route_table" "private_route_table_az2" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway_az2.id
  }

  tags = {
    Name = "${var.project_name}-${var.environment}-private-route-table-az2"
  }
}

#associate private app subnet az1 with private route table az1 
resource "aws_route_table_association" "private_app_subnet_az1_association" {
  subnet_id    = aws_subnet.private_app_subnet_az1.id
  route_table_id = aws_route_table.private_route_table_az1.id
}

#associate private data subnet az1 with private route table az1
resource "aws_route_table_association" "private_data_subnet_az1_association" {
  subnet_id = aws_subnet.private_data_subnet_az1.id
  route_table_id = aws_route_table.private_route_table_az1.id
}

#associate private app subnet az2 with private route table az2
resource "aws_route_table_association" "private_app_subnet_az2_association" {
  subnet_id = aws_subnet.private_app_subnet_az2.id
  route_table_id = aws_route_table.private_route_table_az2.id
}

#associate private data subnet az2 with private route table az2
resource "aws_route_table_association" "private_data_subnet_az2_association" {
  subnet_id = aws_subnet.private_data_subnet_az2.id
  route_table_id = aws_route_table.private_route_table_az2.id
}








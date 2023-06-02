# Creating Nat Gateway
resource "aws_eip" "nat" {
  vpc = true
}

resource "aws_nat_gateway" "nat-gw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.PublicSubnet.id
  depends_on    = [aws_internet_gateway.myIgw]
}

# Add routes for VPC
resource "aws_route_table" "Private"{
   vpc_id = aws_vpc.myvpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gw.id
  }

  tags = {
    Name = "Nat gtw"
  }
}

# Creating route associations for private Subnets
resource "aws_route_table_association" "dev-private-1-a" {
  subnet_id      = aws_subnet.PrivSubnet.id
  route_table_id = aws_route_table.Private.id
}


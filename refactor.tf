moved {
  from = aws_instance.hashiapp
  to   = aws_instance.hashicafe
}

moved {
  from = aws_vpc.hashiapp
  to   = aws_vpc.hashicafe
}

moved {
  from = aws_subnet.hashiapp
  to   = aws_subnet.hashicafe
}

moved {
  from = aws_route_table.hashiapp
  to   = aws_route_table.hashicafe
}

moved {
  from = aws_route_table_association.hashiapp
  to   = aws_route_table_association.hashicafe
}

moved {
  from = aws_internet_gateway.hashiapp
  to   = aws_internet_gateway.hashicafe
}

moved {
  from = aws_security_group.hashiapp
  to   = aws_security_group.hashicafe
}

moved {
  from = aws_eip.hashiapp
  to   = aws_eip.hashicafe
}

moved {
  from = aws_eip_association.hashiapp
  to   = aws_eip_association.hashicafe
}

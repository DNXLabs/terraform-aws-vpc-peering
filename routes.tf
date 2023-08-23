resource "aws_route" "accepter" {
  provider                  = aws.accepter
  for_each                  = { for id in data.aws_route_table.accepter : id => id.route_table_id }
  route_table_id            = each.value
  destination_cidr_block    = data.aws_vpc.requester[0].cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection_accepter.accepter[0].id
}

resource "aws_route" "requester" {
  for_each                  = { for id in data.aws_route_table.requester : id => id.route_table_id }
  route_table_id            = each.value
  destination_cidr_block    = data.aws_vpc.accepter[0].cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.requester[0].id
}
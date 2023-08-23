resource "aws_route" "accepter" {
  provider                  = aws.accepter
  for_each                  = { for k, v in data.aws_route_table.accepter : k => v.id }
  route_table_id            = data.aws_route_table.accepter[each.key].id
  destination_cidr_block    = data.aws_vpc.requester[0].cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection_accepter.accepter[0].id
}

resource "aws_route" "requester" {
  for_each                  = { for k, v in data.aws_route_table.requester : k => v.id }
  route_table_id            = data.aws_route_table.requester[each.key].id
  destination_cidr_block    = var.mode == "complete" ? data.aws_vpc.accepter[0].cidr_block : var.accepter_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.requester[0].id
}
resource "aws_vpc_peering_connection" "requester" {
  count         = local.create_requester ? 0 : 1
  peer_vpc_id   = var.peer_vpc_id
  peer_owner_id = var.peer_owner_id
  vpc_id        = var.vpc_id
  peer_region   = var.accepter_region
}

resource "aws_vpc_peering_connection_accepter" "accepter" {
  count                     = local.create_accepter ? 0 : 1
  provider                  = aws.peer
  vpc_peering_connection_id = local.create_requester ? aws_vpc_peering_connection.requester[0].id : var.requester_connection_id
  auto_accept               = true
}

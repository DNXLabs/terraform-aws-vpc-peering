resource "aws_vpc_peering_connection" "requester" {
  count         = local.create_requester ? 1 : 0
  peer_vpc_id   = var.accepter_vpc_id
  peer_owner_id = var.accepter_owner_id
  vpc_id        = var.requester_vpc_id
  peer_region   = var.accepter_region
}

resource "aws_vpc_peering_connection_accepter" "accepter" {
  count                     = local.create_accepter ? 1 : 0
  provider                  = aws.accepter
  vpc_peering_connection_id = var.mode == "complete" ? aws_vpc_peering_connection.requester[0].id : var.requester_connection_id
  auto_accept               = true
}

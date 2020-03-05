resource "aws_network_acl_rule" "in_accepter_public_from_requester" {
  provider       = aws.peer
  count          = length(data.aws_subnet.requester.*.cidr_block)
  network_acl_id = tolist(data.aws_network_acls.accepter_public.ids)[0]
  rule_number    = 1000 + count.index
  egress         = false
  protocol       = -1
  rule_action    = "allow"
  cidr_block     = data.aws_subnet.requester.*.cidr_block[count.index]
}

resource "aws_network_acl_rule" "out_accepter_public_to_requester" {
  provider       = aws.peer
  count          = length(data.aws_subnet.requester.*.cidr_block)
  network_acl_id = tolist(data.aws_network_acls.accepter_public.ids)[0]
  rule_number    = 1000 + count.index
  egress         = true
  protocol       = -1
  rule_action    = "allow"
  cidr_block     = data.aws_subnet.requester.*.cidr_block[count.index]
}

resource "aws_network_acl_rule" "in_accepter_private_from_requester" {
  provider       = aws.peer
  count          = length(data.aws_subnet.requester.*.cidr_block)
  network_acl_id = tolist(data.aws_network_acls.accepter_private.ids)[0]
  rule_number    = 1000 + count.index
  egress         = false
  protocol       = -1
  rule_action    = "allow"
  cidr_block     = data.aws_subnet.requester.*.cidr_block[count.index]
}

resource "aws_network_acl_rule" "out_accepter_private_to_requester" {
  provider       = aws.peer
  count          = length(data.aws_subnet.requester.*.cidr_block)
  network_acl_id = tolist(data.aws_network_acls.accepter_private.ids)[0]
  rule_number    = 1000 + count.index
  egress         = true
  protocol       = -1
  rule_action    = "allow"
  cidr_block     = data.aws_subnet.requester.*.cidr_block[count.index]
}

resource "aws_network_acl_rule" "in_accepter_secure_from_requester" {
  provider       = aws.peer
  count          = length(data.aws_subnet.requester.*.cidr_block)
  network_acl_id = tolist(data.aws_network_acls.accepter_secure.ids)[0]
  rule_number    = 1000 + count.index
  egress         = false
  protocol       = -1
  rule_action    = "allow"
  cidr_block     = data.aws_subnet.requester.*.cidr_block[count.index]
}

resource "aws_network_acl_rule" "out_accepter_secure_to_requester" {
  provider       = aws.peer
  count          = length(data.aws_subnet.requester.*.cidr_block)
  network_acl_id = tolist(data.aws_network_acls.accepter_secure.ids)[0]
  rule_number    = 1000 + count.index
  egress         = true
  protocol       = -1
  rule_action    = "allow"
  cidr_block     = data.aws_subnet.requester.*.cidr_block[count.index]
}

resource "aws_network_acl_rule" "in_requester_from_accepter" {
  network_acl_id = tolist(data.aws_network_acls.requester.ids)[0]
  rule_number    = 1000 + var.serial
  egress         = false
  protocol       = -1
  rule_action    = "allow"
  cidr_block     = data.aws_vpc.accepter.cidr_block
}

resource "aws_network_acl_rule" "out_requester_to_accepter" {
  network_acl_id = tolist(data.aws_network_acls.requester.ids)[0]
  rule_number    = 1000 + var.serial
  egress         = true
  protocol       = -1
  rule_action    = "allow"
  cidr_block     = data.aws_vpc.accepter.cidr_block
}

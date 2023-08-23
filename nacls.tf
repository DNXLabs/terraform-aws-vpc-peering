
resource "aws_network_acl_rule" "in_accepter_from_requester" {
  provider = aws.accepter
  for_each = { for i, v in local.accepter_nacl_rules : i =>
  { subnet = split(":", v)[0], id = split(":", v)[1] } if local.create_accepter }
  network_acl_id = data.aws_network_acls.accepter[each.value.subnet].id
  rule_number    = 1000 + each.key
  egress         = false
  protocol       = -1
  rule_action    = "allow"
  cidr_block     = data.aws_subnet.requester[each.value.id].cidr_block
}

resource "aws_network_acl_rule" "out_accepter_to_requester" {
  provider = aws.accepter
  for_each = { for i, v in local.accepter_nacl_rules : i =>
  { subnet = split(":", v)[0], id = split(":", v)[1] } if local.create_accepter }
  network_acl_id = data.aws_network_acls.accepter[each.value.subnet].id
  rule_number    = 1000 + each.key
  egress         = true
  protocol       = -1
  rule_action    = "allow"
  cidr_block     = data.aws_subnet.requester[each.value.id].cidr_block
}

resource "aws_network_acl_rule" "in_requester_from_accepter" {
  for_each = { for i, v in local.requester_nacl_rules : i =>
  { subnet = split(":", v)[0], id = split(":", v)[1] } if local.create_requester }
  network_acl_id = data.aws_network_acls.accepter[each.value.subnet].id
  rule_number    = 1000 + var.requester_serial
  egress         = false
  protocol       = -1
  rule_action    = "allow"
  cidr_block     = data.aws_vpc.accepter[0].cidr_block
}

resource "aws_network_acl_rule" "out_requester_to_accepter" {
  for_each = { for i, v in local.requester_nacl_rules : i =>
  { subnet = split(":", v)[0], id = split(":", v)[1] } if local.create_requester }
  network_acl_id = data.aws_network_acls.accepter[each.value.subnet].id
  rule_number    = 1000 + var.requester_serial
  egress         = true
  protocol       = -1
  rule_action    = "allow"
  cidr_block     = data.aws_vpc.accepter[0].cidr_block
}

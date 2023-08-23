data "aws_vpc" "requester" {
  count = local.create_requester ? 1 : 0
  id    = var.requester_vpc_id
}

data "aws_vpc" "accepter" {
  count    = local.create_accepter ? 1 : 0
  provider = aws.accepter
  id       = var.accepter_vpc_id
}

data "aws_subnets" "requester" {
  for_each = toset(var.requester_subnets)

  filter {
    name   = "vpc-id"
    values = [var.requester_vpc_id]
  }

  tags = {
    Scheme = each.value
  }
}

data "aws_subnets" "accepter" {
  provider = aws.accepter
  for_each = toset(var.accepter_subnets)

  filter {
    name   = "vpc-id"
    values = [var.accepter_vpc_id]
  }

  tags = {
    Scheme = each.value
  }
}

data "aws_subnet" "requester" {
  for_each = toset([for id in data.aws_subnets.requester : id.ids][0])
  id       = each.value
}

data "aws_subnet" "accepter" {
  provider = aws.accepter
  for_each = toset([for id in data.aws_subnets.accepter : id.ids][0])
  id       = each.value
}

data "aws_route_table" "requester" {
  for_each  = toset([for id in data.aws_subnets.requester : id.ids][0])
  subnet_id = each.value
}

data "aws_route_table" "accepter" {
  provider  = aws.accepter
  for_each  = toset([for id in data.aws_subnets.accepter : id.ids][0])
  subnet_id = each.value
}

data "aws_network_acls" "accepter" {
  provider = aws.accepter
  for_each = toset(var.accepter_subnets)
  vpc_id   = var.accepter_vpc_id

  tags = {
    Scheme = each.value
  }
}

data "aws_network_acls" "requester" {
  for_each = toset(var.requester_subnets)
  vpc_id   = var.requester_vpc_id

  tags = {
    Scheme = each.value
  }
}

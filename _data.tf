data "aws_vpc" "requester" {
  id = var.vpc_id
}

data "aws_vpc" "accepter" {
  provider = aws.peer
  id       = var.peer_vpc_id
}

data "aws_subnets" "requester" {
  filter {
    name   = "vpc_id"
    values = [var.peer_vpc_id]
  }


  tags = {
    Scheme = "transit"
  }
}

data "aws_subnet" "requester" {
  count = length(data.aws_subnets.requester.ids)
  id    = tolist(data.aws_subnets.requester.ids)[count.index]
}

data "aws_subnets" "accepter_public" {
  provider = aws.peer

  filter {
    name   = "vpc_id"
    values = [var.peer_vpc_id]
  }

  tags = {
    Scheme = "public"
  }
}

data "aws_subnets" "accepter_private" {
  provider = aws.peer

  filter {
    name   = "vpc_id"
    values = [var.peer_vpc_id]
  }

  tags = {
    Scheme = "private"
  }
}

data "aws_subnets" "accepter_secure" {
  provider = aws.peer

  filter {
    name   = "vpc_id"
    values = [var.peer_vpc_id]
  }

  tags = {
    Scheme = "secure"
  }
}

data "aws_route_table" "accepter_public" {
  provider  = aws.peer
  count     = length(data.aws_subnets.accepter_public.ids)
  subnet_id = tolist(data.aws_subnets.accepter_public.ids)[count.index]
}

data "aws_route_table" "accepter_private" {
  provider  = aws.peer
  count     = length(data.aws_subnets.accepter_private.ids)
  subnet_id = tolist(data.aws_subnets.accepter_private.ids)[count.index]
}

data "aws_route_table" "accepter_secure" {
  provider  = aws.peer
  count     = length(data.aws_subnets.accepter_secure.ids)
  subnet_id = tolist(data.aws_subnets.accepter_secure.ids)[count.index]
}

data "aws_route_table" "requester" {
  count     = length(data.aws_subnets.requester.ids)
  subnet_id = tolist(data.aws_subnets.requester.ids)[count.index]
}

data "aws_network_acls" "accepter_public" {
  provider = aws.peer
  vpc_id   = var.peer_vpc_id

  tags = {
    Scheme = "public"
  }
}

data "aws_network_acls" "accepter_private" {
  provider = aws.peer
  vpc_id   = var.peer_vpc_id

  tags = {
    Scheme = "private"
  }
}

data "aws_network_acls" "accepter_secure" {
  provider = aws.peer
  vpc_id   = var.peer_vpc_id

  tags = {
    Scheme = "secure"
  }
}

data "aws_network_acls" "requester" {
  vpc_id = var.vpc_id

  tags = {
    Scheme = "transit"
  }
}

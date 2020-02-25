variable "peer_vpc_id" {
  description = "VPC ID of accepter"
}

variable "peer_owner_id" {
  description = "Account ID of accepter"
}

variable "vpc_id" {
  description = "VPC ID of requester"
}

variable "serial" {
  default     = 0
  description = "Number of this peering, distinct from others, to avoid conflict with NACL rule number"
}

variable "accepter_region" {
  description = "Region of acccepter"
}

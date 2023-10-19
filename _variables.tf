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

#===== subnet variables =====#
variable "accepter_public_subnets_filter" {
  type = object({
    name   = string,
    values = list(string)
  })
  description = "List of public subnet IDs of accepter"
  default     = { name = "tag:Scheme", values = ["public"] }
}

variable "accepter_private_subnets_filter" {
  type = object({
    name   = string,
    values = list(string)
  })
  description = "List of private subnet IDs of accepter"
  default     = { name = "tag:Scheme", values = ["private"] }
}

variable "accepter_secure_subnets_filter" {
  type = object({
    name   = string,
    values = list(string)
  })
  description = "List of secure subnet IDs of accepter"
  default     = { name = "tag:Scheme", values = ["secure"] }
}

variable "requester_transit_subnets_filter" {
  type = object({
    name   = string,
    values = list(string)
  })
  description = "List of secure subnet IDs of accepter"
  default     = { name = "tag:Scheme", values = ["transit"] }
}

#===== nacls filter =====#
variable "accepter_public_nacls_filter" {
  type = object({
    name   = string,
    values = list(string)
  })
  description = "Filter of public NACLs"
  default     = { name = "tag:Scheme", values = ["public"] }
}
variable "accepter_private_nacls_filter" {
  type = object({
    name   = string,
    values = list(string)
  })
  description = "Filter of private NACLs"
  default     = { name = "tag:Scheme", values = ["private"] }
}
variable "accepter_secure_nacls_filter" {
  type = object({
    name   = string,
    values = list(string)
  })
  description = "Filter of secure NACLs"
  default     = { name = "tag:Scheme", values = ["secure"] }
}

variable "requester_transit_nacls_filter" {
  type = object({
    name   = string,
    values = list(string)
  })
  description = "Filter of transit NACLs"
  default     = { name = "tag:Scheme", values = ["transit"] }
}

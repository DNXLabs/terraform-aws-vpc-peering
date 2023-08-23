variable "accepter_vpc_id" {
  description = "VPC ID of accepter"
}

variable "accepter_owner_id" {
  description = "Account ID of accepter"
}

variable "requester_vpc_id" {
  description = "VPC ID of requester"
}

variable "requester_serial" {
  default     = 0
  description = "Number of this peering, distinct from others, to avoid conflict with NACL rule number"
}

variable "accepter_region" {
  description = "Region of acccepter"
}

variable "accepter_subnets" {
  description = "Subnets of accepter"
  type        = list(string)
  default     = []
}

variable "accepter_cidr_block" {
  description = "CIDR block of accepter"
  default     = ""
}

variable "requester_subnets" {
  description = "Subnets of accepter"
  type        = list(string)
  default     = ["transit"]
}

variable "mode" {
  description = "Defines if the module will create accepter or requester or both"
  default     = "complete"

  validation {
    condition     = contains(["complete", "requester", "accepter"], var.mode)
    error_message = "Valid values for mode are: (complete, requester, accepter)."
  }
}

variable "requester_connection_id" {
  description = "Id of requester vpc peering connection if not creating inside module"
  default     = ""
}

locals {
  create_requester = var.mode == "complete" || var.mode == "requester"
  create_accepter  = var.mode == "complete" || var.mode == "accepter"
  accepter_nacl_rules = flatten([
    for subnet in var.accepter_subnets : [for id in data.aws_subnets.accepter[subnet].ids : "${subnet}:${id}"]
  ])
  requester_nacl_rules = flatten([
    for subnet in var.accepter_subnets : [for id in data.aws_subnets.accepter[subnet].ids : "${subnet}:${id}"]
  ])
}
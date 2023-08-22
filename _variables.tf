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

variable "mode" {
  description = "Defines if the module will create accepter or requester or both"
  default = "complete"

  validation {
    condition = contains(["complete", "requester", "accepter"], var.mode)
    error_message = "Valid values for mode are: (complete, requester, accepter)"
  }
}

variable "requester_connection_id" {
  description = "Id of requester vpc peering connection if not creating inside module"
}

locals {
  create_requester  = var.mode == "complete" || var.mode == "requester"
  create_accepter = var.mode == "complete" || var.mode == "accepter"
}
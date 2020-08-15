# terraform-aws-vpc-peering

[![Lint Status](https://github.com/DNXLabs/terraform-aws-vpc-peering/workflows/Lint/badge.svg)](https://github.com/DNXLabs/terraform-aws-vpc-peering/actions)
[![LICENSE](https://img.shields.io/github/license/DNXLabs/terraform-aws-vpc-peering)](https://github.com/DNXLabs/terraform-aws-vpc-peering/blob/master/LICENSE)

This terraform module provide resources to manage Virtual Private Cloud (VPC) peering connections. A VPC peering connection is a networking connection between two VPCs that enables you to route traffic between them using private IPv4 addresses or IPv6 addresses.

The following resources will be created:

 - A VPC requester - VPC that sends a request to the owner of the accepter VPC to create the VPC peering connection
 - A VPC Accepter - VPC  that accepts the VPC peering connection request to activate the VPC peering connection.
 - A route table  - That contains a set of rules, called routes, that are used to determine where network traffic from your subnet or gateway is directed.
 - Network Access Control list (ACL) - NACLs provide a rule-based tool for controlling network traffic ingress and egress at the protocol and subnet level.
     - in_accepter_public_from_requester
     - out_accepter_public_to_requester
     - in_accepter_private_from_requester
     - out_accepter_private_to_requester
     - in_accepter_secure_from_requester
     - out_accepter_secure_to_requester
     - in_requester_from_accepter
     - out_requester_to_accepter

<!--- BEGIN_TF_DOCS --->

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12.20 |

## Providers

| Name | Version |
|------|---------|
| aws | n/a |
| aws.peer | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| accepter\_region | Region of acccepter | `any` | n/a | yes |
| peer\_owner\_id | Account ID of accepter | `any` | n/a | yes |
| peer\_vpc\_id | VPC ID of accepter | `any` | n/a | yes |
| serial | Number of this peering, distinct from others, to avoid conflict with NACL rule number | `number` | `0` | no |
| vpc\_id | VPC ID of requester | `any` | n/a | yes |

## Outputs

No output.

<!--- END_TF_DOCS --->

## Author

Module managed by [DNX Solutions](https://github.com/DNXLabs).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/DNXLabs/terraform-aws-vpc-peering/blob/master/LICENSE) for full details.

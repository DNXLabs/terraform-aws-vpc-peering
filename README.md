# terraform-aws-vpc-peering

[![Lint Status](https://github.com/DNXLabs/terraform-aws-vpc-peering/workflows/Lint/badge.svg)](https://github.com/DNXLabs/terraform-aws-vpc-peering/actions)
[![LICENSE](https://img.shields.io/github/license/DNXLabs/terraform-aws-vpc-peering)](https://github.com/DNXLabs/terraform-aws-vpc-peering/blob/master/LICENSE)

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
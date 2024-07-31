terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 3.76.1"
      configuration_aliases = [
        aws.peer,
      ]
    }
  }
  required_version = ">= 0.13"
}


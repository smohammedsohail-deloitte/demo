terraform {
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.15.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.38"
    }
  }
}

# Configure the Azure Active Directory Provider
provider "azuread" {
  tenant_id = "9b7cbd77-6d6b-4879-8aba-63d7dfb18472"
}

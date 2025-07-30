# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.1.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
  subscription_id = var.subscription_id
  resource_provider_registrations = "none"
}

resource "azurerm_policy_definition" "require_tags_on_resources" {
  name         = var.policy_name
  policy_type  = "Custom"
  mode         = "Indexed"
  display_name = "Require tags on all resources"
  description  = "Ensures that all indexed resources have tags. Denies deployment if tags are missing."
  policy_rule  = <<POLICY_RULE
{
  "if": {
    "allOf": [
      {
        "field": "type",
        "notEquals": "Microsoft.Resources/subscriptions/resourceGroups"
      },
      {
        "field": "tags",
        "exists": "false"
      }
    ]
  },
  "then": {
    "effect": "deny"
  }
}
POLICY_RULE
  metadata = <<METADATA
{
  "version": "1.0.0",
  "category": "Tags"
}
METADATA
}
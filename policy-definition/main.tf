provider "azurerm" {
  features {}
  subscription_id = "28e1e42a-4438-4c30-9a5f-7d7b488fd88"
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
    "field": "tags",
    "exists": "false"
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
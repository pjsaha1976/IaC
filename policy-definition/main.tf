resource "azurerm_policy_definition" "require_tags_on_resources" {
  name         = var.policy_name
  policy_type  = "Custom"
  mode         = "Indexed"
  display_name = "Require tags on all resources (except resource groups)"
  description  = "Ensures that all indexed resources except resource groups have tags. Denies deployment if tags are missing."
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
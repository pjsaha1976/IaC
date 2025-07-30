# Azure Policy: Require Tags on All Resources

This Terraform module defines a custom Azure Policy that ensures all indexed resources in your Azure subscription have at least one tag. If a resource is created or updated without tags, the deployment will be denied.

## Policy Details

- **Policy Name:** User-defined via the `policy_name` variable
- **Policy Type:** Custom
- **Mode:** Indexed
- **Effect:** Deny deployment if tags are missing
- **Category:** Tags

## Usage

1. **Deploy the Policy**

   Initialize and apply the Terraform configuration:

   ```sh
   az login --service-principal -u CLIENT_ID -p CLIENT_SECRET --tenant TENANT_ID
   terraform init
   terraform apply
   ```

2. **Assign the Policy**

   After deployment, assign the policy to a subscription or resource group using the command below.

   ```sh
   az policy assignment create --policy tagging-policy
   ```

3. **List the Policy Assigments**

   List the policy assignment using the command below.

   ```sh
   az policy assignment list
   ```

## Policy Rule

This policy denies the creation of any resource that does not have at least one tag:

```json
{
  "if": {
    "field": "tags",
    "exists": "false"
  },
  "then": {
    "effect": "deny"
  }
}
```

## Best Practices

- Assign this policy at the subscription or management group level for broad enforcement.
- Use meaningful tag keys and values to support resource governance and cost management.

## References
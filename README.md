# Getting Started Guide for IaC Azure Infrastructure

Welcome! This guide will help you quickly deploy the Azure infrastructure defined in the `IaC` folder using Terraform and Packer.

---

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) v1.0+
- [Packer](https://www.packer.io/downloads)
- An Azure subscription
- Azure Service Principal credentials with sufficient permissions

---

## 1. Clone the Repository

```sh
git clone https://github.com/pjsaha1976/IaC.git
cd IaC
```

---

## 2. Build the Custom VM Image with Packer

1. **Set Azure authentication environment variables:**

   ```sh
   export ARM_CLIENT_ID="your-azure-client-id"
   export ARM_CLIENT_SECRET="your-azure-client-secret"
   export ARM_SUBSCRIPTION_ID="your-azure-subscription-id"
   export ARM_TENANT_ID="your-azure-tenant-id"
   ```

2. **Install the Azure Packer plugin (if not already installed):**

   ```sh
   packer plugins install github.com/hashicorp/azure
   ```

3. **Build the image:**

   ```sh
   cd packer-template
   packer build server.json
   cd ..
   ```

---

## 3. Configure Terraform Variables

Create a `terraform.tfvars` file in the `terraform-template` directory with content like:

```hcl
prefix         = "demo"
location       = "East US"
admin_password = "YourSecurePassword123!"
vm_count       = 1
```

---

## 4. Deploy Azure Infrastructure with Terraform

1. **Navigate to the Terraform directory:**

   ```sh
   cd terraform-template
   ```

2. **Initialize Terraform:**

   ```sh
   terraform init
   ```

3. **Review the plan:**

   ```sh
   terraform plan
   ```

4. **Apply the deployment:**

   ```sh
   terraform apply
   ```

---

## 5. Clean Up

To destroy all resources created by this template:

```sh
terraform destroy
```

---

## References

- [Terraform Azure Provider Documentation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
- [Packer Azure Builder Documentation](https://developer.hashicorp.com/packer/plugins/builders/azure/azure-arm)
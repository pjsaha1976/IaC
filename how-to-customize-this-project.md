# Customizing Your Azure IaC Project

This guide explains how you can tailor the IaC project in this repository to fit your specific Azure infrastructure needs.

---

## 1. Change Resource Naming

All resources use a `prefix` variable for naming.  
**To customize:**  
Edit the `prefix` value in your `terraform.tfvars` file:

```hcl
prefix = "your-custom-prefix"
```

---

## 2. Adjust Azure Region

Set the Azure region for all resources by updating the `location` variable:

```hcl
location = "West Europe"
```

---

## 3. Configure VM Settings

- **VM Count:**  
  Deploy multiple VMs by changing the `vm_count` variable:

  ```hcl
  vm_count = 3
  ```

- **Admin Username & Password:**  
  Update the `admin_username` in `main.tf` and set a secure `admin_password` in `terraform.tfvars`:

  ```hcl
  admin_password = "YourSecurePassword123!"
  ```

---

## 4. Use Your Own Packer Image

- **Image Name:**  
  If you build a new image with Packer, update the image name in the `data "azurerm_image"` block in `main.tf`:

  ```hcl
  name = "your-packer-image-name"
  ```

---

## 5. Modify Network Settings

- **Virtual Network & Subnet:**  
  Change address spaces and subnet prefixes in `main.tf`:

  ```hcl
  address_space   = ["10.1.0.0/16"]
  address_prefixes = ["10.1.1.0/24"]
  ```

- **Network Security Group (NSG) Rules:**  
  Edit or add rules in the NSG resource to allow/deny specific traffic.

---

## 6. Load Balancer & Public IP

- **Frontend/Backend Pool:**  
  Add or remove backend pool associations as needed for your VM scale.

- **Public IP:**  
  Change the SKU or allocation method in the `azurerm_public_ip` resource.

---

## 7. Add More Disks or Resources

- **Managed Disks:**  
  Duplicate or adjust the `azurerm_managed_disk` and attachment resources to add more data disks.

- **Other Azure Resources:**  
  Add new Terraform resources as needed (e.g., databases, storage accounts).

---

## 8. Secure Your Secrets

- Use environment variables or secret managers for sensitive values.
- Never commit passwords or secrets to version control.

---

## 9. Clean Up

To remove all resources:

```sh
terraform destroy
```

---

## References

- [Terraform Azure Provider Docs](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
- [Packer Azure Builder Docs](https://developer.hashicorp.com/packer/plugins/builders/azure/azure-arm)

---

**Tip:**  
Review and edit the `variables.tf` and vars.tf  files to see all configurable options for this project
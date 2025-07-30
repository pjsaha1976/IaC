# Terraform Azure Infrastructure Template

This folder contains Terraform code to provision a basic Azure infrastructure, including:

- Virtual Network and Subnet
- Network Security Group (NSG) with rules to block internet access and allow intra-subnet traffic
- Network Interface(s)
- Public IP and Load Balancer with backend pool
- Availability Set
- Managed Disk(s) and Data Disk Attachment
- Linux Virtual Machine(s) using a custom Packer image

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) v1.0+
- An Azure subscription
- Service Principal credentials with sufficient permissions

## Configuration

Set the following variables in a `terraform.tfvars` file or via CLI:

```hcl
prefix        = "demo"
location      = "East US"
admin_password = "YourSecurePassword123!"
vm_count      = 1
```

## Usage

1. **Initialize Terraform**

   ```sh
   terraform init
   ```

2. **Plan the Deployment**

   ```sh
   terraform plan
   ```

3. **Apply the Deployment**

   ```sh
   terraform apply
   ```

## Customization

- Change `vm_count` to deploy multiple VMs.
- Update `admin_password` for VM SSH/password login.
- Adjust `prefix` to customize resource names.
- Edit NSG rules in `main.tf` to fit your security requirements.

## Notes

- The VM(s) are deployed using a managed image built with Packer (`packer-ubuntu-server`).
- The public IP is attached to the load balancer, not directly to the VM NIC.
- All resources are created in the `Azuredevops` resource group by default.

## Clean Up

To destroy all resources created by this template:

```sh
terraform destroy
```

## References

- [Terraform Azure Provider Documentation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
# Packer Template for Azure Ubuntu Server

This repository contains a Packer template to build a managed image on Azure using Ubuntu Server. The image includes a simple HTTP server for demonstration.

## Features

- Builds an Ubuntu 18.04-LTS managed image using the Azure ARM builder.
- Installs BusyBox and runs a basic HTTP server on port 80.
- Uses environment variables for secure Azure authentication.

## Prerequisites

- [Packer](https://www.packer.io/downloads)
- An Azure subscription
- Service Principal credentials with permissions to create resources

## Environment Variables

Set the following environment variables before running Packer:

```sh
export ARM_CLIENT_ID="your-azure-client-id"
export ARM_CLIENT_SECRET="your-azure-client-secret"
export ARM_SUBSCRIPTION_ID="your-azure-subscription-id"
export ARM_TENANT_ID="your-azure-tenant-id"
```

## Install Azure Plugin for Packer

Before building, install the Azure plugin:

```sh
packer plugins install github.com/hashicorp/azure
```

## Usage

1. **Build the Image**

   ```sh
   packer build server.json
   ```

2. **Result**

   The build creates a managed image in the specified Azure resource group (`Azuredevops`). You can use this image to launch VMs with the HTTP server pre-installed.

## Template Overview

- **builders**: Uses the `azure-arm` builder to create an Ubuntu image in Azure.
- **provisioners**: Installs BusyBox and sets up a basic HTTP server.

## Customization

- Update the `managed_image_resource_group_name`, `location`, or VM size as needed in `server.json`.
- Modify the provisioner section to deploy your own application or additional dependencies.

## References

-
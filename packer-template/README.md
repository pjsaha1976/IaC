# Packer Template for Flask Web Server on Azure Ubuntu VM

This repository contains a Packer template to build an Azure-managed image with Ubuntu and a sample Flask web server pre-installed.

## Features

- Builds an Ubuntu 18.04-LTS image using Azure ARM builder.
- Installs Python 3 and Flask.
- Deploys a simple Flask web application running on port 80.
- Uses environment variables for Azure authentication.

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
```

## Usage

1. **Build the Image**

   ```sh
   packer plugins install github.com/hashicorp/azure
   packer build server.json
   ```

2. **Result**

   The build creates a managed image in the specified Azure resource group. You can use this image to launch VMs with Flask pre-installed.

## Template Overview

- **builders**: Uses the `azure-arm` builder to create an Ubuntu image in Azure.
- **provisioners**: Installs Python, Flask, and sets up a basic Flask app.

## Customization

- Update the `resource_group_name`, `location`, or VM size as needed in `server.json`.
- Modify the provisioner section to deploy your own Flask app or additional dependencies.

## References

- [Packer Azure Builder Documentation](https://developer.hashicorp.com/packer/plugins/builders/azure/azure-arm)
-
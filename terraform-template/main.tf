provider "azurerm" {
  features {}
}

resource "azurerm_virtual_network" "main_vnet" {
  name                = "${var.prefix}-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = "Azuredevops"
}

resource "azurerm_subnet" "main_subnet" {
  name                 = "${var.prefix}-subnet"
  resource_group_name  = "Azuredevops"
  virtual_network_name = azurerm_virtual_network.main_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_security_group" "main_nsg" {
  name                = "${var.prefix}-nsg"
  location            = var.location
  resource_group_name = "Azuredevops"

  security_rule {
    name                       = "Allow-Subnet-Inbound"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "10.0.1.0/24"
    destination_address_prefix = "10.0.1.0/24"
  }

  security_rule {
    name                       = "Deny-Internet-Inbound"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "main_assoc" {
  subnet_id                 = azurerm_subnet.main_subnet.id
  network_security_group_id = azurerm_network_security_group.main_nsg.id
}

resource "azurerm_network_interface" "main_nic" {
  name                = "${var.prefix}-nic"
  location            = var.location
  resource_group_name = "Azuredevops"

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.main_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.main_public_ip.id
  }
}

resource "azurerm_public_ip" "main_public_ip" {
  name                = "${var.prefix}-public-ip"
  location            = var.location
  resource_group_name = "Azuredevops"
  allocation_method   = "Dynamic"
  sku                 = "Basic"
}

resource "azurerm_lb" "main_lb" {
  name                = "${var.prefix}-lb"
  location            = var.location
  resource_group_name = "Azuredevops"
  sku                 = "Basic"

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.main_public_ip.id
  }
}

resource "azurerm_lb_backend_address_pool" "main_bepool" {
  name                = "${var.prefix}-bepool"
  loadbalancer_id     = azurerm_lb.main_lb.id
}

resource "azurerm_network_interface_backend_address_pool_association" "main_nic_lb_assoc" {
  network_interface_id    = azurerm_network_interface.main_nic.id
  ip_configuration_name   = "internal"
  backend_address_pool_id = azurerm_lb_backend_address_pool.main_bepool.id
}

resource "azurerm_availability_set" "main_avset" {
  name                         = "${var.prefix}-avset"
  location                     = var.location
  resource_group_name          = "Azuredevops"
  platform_fault_domain_count  = 2
  platform_update_domain_count = 2
  managed                      = true
}

data "azurerm_image" "packer_image" {
  name                = "packer-ubuntu-server"
  resource_group = "Azuredevops"
}

resource "azurerm_linux_virtual_machine" "main_vm" {
  name                = "${var.prefix}-vm"
  location            = var.location
  resource_group_name = "Azuredevops"
  size                = "Standard_D2s_v3"
  admin_username      = "pjsaha"
  network_interface_ids = [
    azurerm_network_interface.main_nic.id
  ]
  availability_set_id = azurerm_availability_set.main_avset.id

  source_image_id = data.azurerm_image.packer_image.id

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    name                 = "${var.prefix}-osdisk"
  }

 disable_password_authentication = false
 admin_password                  = var.admin_password
}

resource "azurerm_managed_disk" "main_data_disk" {
  name                 = "${var.prefix}-datadisk"
  location             = var.location
  resource_group_name  = "Azuredevops"
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = 64
}

resource "azurerm_virtual_machine_data_disk_attachment" "main_data_disk_attach" {
  managed_disk_id    = azurerm_managed_disk.main_data_disk.id
  virtual_machine_id = azurerm_linux_virtual_machine.main_vm.id
  lun                = 0
  caching            = "ReadWrite"
}
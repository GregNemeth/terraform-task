// Virtual Network

resource "azurerm_virtual_network" "main" {
    name                = "${var.project_name}-vnet"
    address_space       = ["10.0.0.0/16"]
    location            = var.location
    resource_group_name = var.group_name
}


// Public Subnet with NSG allowing SSH from everywhere

resource "azurerm_subnet" "public" {
    name                 = "internal"
    resource_group_name  = var.group_name
    virtual_network_name = azurerm_virtual_network.main.name
    address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "public" {
    name                = "${var.project_name}-public_nic"
    location            = var.location
    resource_group_name = var.group_name

    ip_configuration {
        name                          = "internal"
        subnet_id                     = azurerm_subnet.public.id
        private_ip_address_allocation = "Dynamic"
    }
}

resource "azurerm_network_security_group" "public_ssh" {
  name                = "public-nsg"
  location            = var.location
  resource_group_name = var.group_name

  security_rule {
    name                       = "ssh-from-any"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "public-ssh" {
  subnet_id                 = azurerm_subnet.public.id
  network_security_group_id = azurerm_network_security_group.public_ssh.id
}

// Private Subnet with NSG allowing SSH only from public subnet


resource "azurerm_subnet" "private" {
    name                 = "internal"
    resource_group_name  = var.group_name
    virtual_network_name = azurerm_virtual_network.main.name
    address_prefixes     = ["10.0.3.0/24"]
}

resource "azurerm_network_interface" "private" {
    name                = "${var.project_name}-private_nic"
    location            = var.location
    resource_group_name = var.group_name

    ip_configuration {
        name                          = "internal"
        subnet_id                     = azurerm_subnet.private.id
        private_ip_address_allocation = "Dynamic"
    }
}

resource "azurerm_network_security_group" "private_ssh" {
  name                = "private-nsg"
  location            = var.location
  resource_group_name = var.group_name

  security_rule {
    name                       = "ssh-from-public-only"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "10.0.2.0/24"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "private-ssh" {
  subnet_id                 = azurerm_subnet.private.id
  network_security_group_id = azurerm_network_security_group.private_ssh.id
}

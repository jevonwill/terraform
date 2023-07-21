terraform {
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = "=3.0.0"
    }
  } 
}

#Configure Azure Provider
provider "azurerm" {
    features {}
}

#Create Publix Demo ResourceGroup
resource "azurerm_resource_group" "publix-demo-rg" {
    name = "publix-demo-resources"
    location = "East US"
    tags = {
        environment = "demo"
    }
}

#Create Publix Demo Network
resource "azurerm_virtual_network" "publix-demo-network" {
    name = "publix-demo-network"
    resource_group_name = azurerm_resource_group.publix-demo-rg.name
    location = azurerm_resource_group.publix-demo-rg.location
    address_space = ["10.11.0.0/16"]

    tags = {
        environment = "demo"
    }

}

#Create Publix Demo Subnets
resource "azurerm_subnet" "public-1" {
    name = "public-subnet-1"
    resource_group_name = azurerm_resource_group.publix-demo-rg.name
    virtual_network_name = azurerm_virtual_network.publix-demo-network.name
    address_prefixes = ["10.11.1.0/24"]
}

resource "azurerm_subnet" "private-1" {
    name = "private-subnet-1"
    resource_group_name = azurerm_resource_group.publix-demo-rg.name
    virtual_network_name = azurerm_virtual_network.publix-demo-network.name
    address_prefixes = ["10.11.2.0/24"]
}

#Create network security groups

resource "azurerm_network_security_group" "public-access-sg" {
    name = "public-access-sg"
    location = azurerm_resource_group.publix-demo-rg.location
    resource_group_name = azurerm_resource_group.publix-demo-rg.name

   
    tags = {
        environment = "demo"
  }
}

#Create network security rules
resource "azurerm_network_security_rule" "public-access-rule" {
  name                        = "inbound-port-80"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "80"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.publix-demo-rg.name
  network_security_group_name = azurerm_network_security_group.public-access-sg.name
}

resource "azurerm_network_security_rule" "ssh-access" {
  name                        = "ssh-access"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "22"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.publix-demo-rg.name
  network_security_group_name = azurerm_network_security_group.public-access-sg.name
}
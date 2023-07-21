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

resource "azurerm_virtual_network" "publix-demo-network" {
    name = "publix-demo-network"
    resource_group_name = azurerm_resource_group.publix-demo-rg.name
    location = azurerm_resource_group.publix-demo-rg.location
    address_space = ["10.11.0.0/16"]

    tags = {
        environment = "demo"
    }

}


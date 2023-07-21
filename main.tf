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
resource "azurerm_resource_group" "publix-demo" {
    name = "publix-demo"
    location = "East US"
}


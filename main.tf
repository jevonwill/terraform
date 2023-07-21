terraform {
  required_version = "=3.0.0" {
    azurerm = {
        source = "hashicorp/azurerm"
        version = "=3.0.0"
    }
  } 
}

#Configure Azure Provider
provider "azurerm" {
    feature {}
}

#Create Publix Demo ResourceGroup
resource "azurerm_resource_group" "publix-demo" {
    name = "publix-demo"
    location = "US East"
}


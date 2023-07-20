#!/bin/sh
#Terraform installation

#Ensure system is update and install dependencies 
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common

#Install HashiCorp GPG key
wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | \
sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg

#Verify fingerprint
gpg --no-default-keyring \
--keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
--fingerprint

#Add HashiCorp repos
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list

#Download package info
sudo apt update

#Install Terraform from the new repository.
sudo apt-get install terraform
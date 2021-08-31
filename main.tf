// Terraform configuration


// Provider


// Resource Group


// Virtual Network module
module "virtual_network" {
  source = "./vnet"
  // variables passed down to child modules here
}

// Virtual Machines module
module "virtual_machine" {
  source = "./vm"
  // variables passed down to child modules here
}

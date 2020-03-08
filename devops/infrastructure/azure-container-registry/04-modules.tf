# module "container-registry" {
#   source = "../azure-infraestructure-as-code/modules/container-registry"

#   # resource_group_name = "${var.resource_group_name}"
#   # location = "${var.location}"
# }

resource "azurerm_resource_group" "registry" {
  name     = "${var.resource_group_name}"
  location = "${var.location}"
}

resource "azurerm_container_registry" "registrycontainers" {
  name                = "${var.container_registry_name}"
  resource_group_name = "${azurerm_resource_group.registry.name}"
  location            = "${azurerm_resource_group.registry.location}"
  admin_enabled       = true
  sku                 = "Standard"
}

output "login_server" {
  value = "${azurerm_container_registry.registrycontainers.login_server}"
}
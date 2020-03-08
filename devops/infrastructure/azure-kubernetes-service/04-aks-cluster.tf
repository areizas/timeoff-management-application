locals {
  admin_username       = "adminuser"
  admin_ssh_public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC6NBkPKkJwZ624YMLxlSXDckcNwgKRZNO0gb4bxHY3clKi54JaCZcK/Nfdwv762vKk8TqonoBfg60FW0KrKNrvhbGPpP6DjJk4KmnheNJogGKghz3bCVLCGUhxVdhtYGRm5FxX680yhRYvzNmipZaAHeBzbtDGri0I3i/NTbAALWR2WxCGfyYDe251EPWLefq09naKuUzlvNJvp2sUt7e/d2niQo/HvEImgs8L8UepoOz8KdnJQGFNfsbWH/jvO0KuKIxb31M/G10KDla3oKkHcxDduU00qgvnQGny8Hs7qQOgY+rmT8Qv2kx1GSojRZB1CFw4Na4UZyOOEJEC7IR9 areizas@areizas"
}


resource "azurerm_resource_group" "resource_group" {
  name     = "${var.resource_group_name}"
  location = "${var.location}"

}

resource "azurerm_kubernetes_cluster" "test" {
  name                   = "${var.cluster_name}"
  resource_group_name    = "${azurerm_resource_group.resource_group.name}"
  location               = "${var.location}"
  dns_prefix          = "${var.dns_name_prefix}"


  agent_pool_profile {
    name       = "agentpools"
    count      = "${var.linux_agent_count}"
    vm_size    = "${var.linux_agent_vm_size}"
  }

  linux_profile {
    admin_username = "${local.admin_username}"

    ssh_key {
      key_data = "${local.admin_ssh_public_key}"
    }
  }

  service_principal {
    client_id     = "${var.client_id}"
    client_secret = "${var.client_secret}"
  }

}


output "id" {
  value = "${azurerm_kubernetes_cluster.test.id}"
}

output "kube_config" {
  value = "${azurerm_kubernetes_cluster.test.kube_config_raw}"
}

output "client_key" {
  value = "${azurerm_kubernetes_cluster.test.kube_config.0.client_key}"
}

output "client_certificate" {
  value = "${azurerm_kubernetes_cluster.test.kube_config.0.client_certificate}"
}

output "cluster_ca_certificate" {
  value = "${azurerm_kubernetes_cluster.test.kube_config.0.cluster_ca_certificate}"
}

output "host" {
  value = "${azurerm_kubernetes_cluster.test.kube_config.0.host}"
}

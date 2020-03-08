terraform {
  backend "azurerm" {
    storage_account_name = "mateoterraformstates"
    container_name       = "terraformstates"
    key                  = "acr.terraform.tfstate"
    access_key           = "#{ACCESS_KEY}#"
  }
}
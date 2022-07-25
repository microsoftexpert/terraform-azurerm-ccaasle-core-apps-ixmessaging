resource "azurerm_key_vault_secret" "ixmessaging_password" {
  name         = "ixmessagingpassword"
  value        = random_password.ixmessaging_password.result
  key_vault_id = data.azurerm_key_vault.customer_keyvault.id
}


output "icon_url" {
  value = azurerm_storage_blob.greeting_icon.url
}

output "storage_account_name" {
  value = azurerm_storage_account.sa.name
}

output "static_site_endpoint" {
  value = azurerm_storage_account.sa.primary_web_endpoint
}

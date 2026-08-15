output "dev_access_key_id" {
  value = module.iam.access_key_id
}

output "dev_secret_access_key" {
  value     = module.iam.secret_access_key
  sensitive = true
}

output "dev_console_password" {
  value     = module.iam.console_password
  sensitive = true
}

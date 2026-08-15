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

output "assets_bucket_name" {
  value = module.serverless.assets_bucket_name
}

output "catalog_mysql_endpoint" {
  value = module.data.catalog_mysql_endpoint
}

output "orders_postgres_endpoint" {
  value = module.data.orders_postgres_endpoint
}

output "carts_table_name" {
  value = module.data.carts_table_name
}

output "carts_dynamodb_role_arn" {
  value = module.data.carts_dynamodb_role_arn
}

output "github_actions_role_arn" {
  value = module.github_oidc.github_actions_role_arn
}

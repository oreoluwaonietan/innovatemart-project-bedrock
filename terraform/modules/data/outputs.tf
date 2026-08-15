output "catalog_mysql_endpoint" {
  value = aws_db_instance.catalog_mysql.endpoint
}

output "catalog_mysql_secret_arn" {
  value = aws_db_instance.catalog_mysql.master_user_secret[0].secret_arn
}

output "orders_postgres_endpoint" {
  value = aws_db_instance.orders_postgres.endpoint
}

output "orders_postgres_secret_arn" {
  value = aws_db_instance.orders_postgres.master_user_secret[0].secret_arn
}

output "carts_table_name" {
  value = aws_dynamodb_table.carts.name
}

output "access_key_id" {
  value = aws_iam_access_key.bedrock_dev_view.id
}

output "secret_access_key" {
  value     = aws_iam_access_key.bedrock_dev_view.secret
  sensitive = true
}

output "user_arn" {
  value = aws_iam_user.bedrock_dev_view.arn
}

output "console_password" {
  value     = aws_iam_user_login_profile.bedrock_dev_view.password
  sensitive = true
}

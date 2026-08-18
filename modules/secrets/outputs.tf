output "secret_arns" {
  description = "Map of logical secret name (upper-cased at consumption time) -> Secrets Manager ARN."
  value = merge(
    { for k in var.generated_secret_names : k => aws_secretsmanager_secret.generated[k].arn },
    {
      database_url             = aws_secretsmanager_secret.database_url.arn
      azure_ad_client_id       = aws_secretsmanager_secret.azure_ad_client_id.arn
      azure_mail_client_secret = aws_secretsmanager_secret.azure_mail_client_secret.arn
    }
  )
}

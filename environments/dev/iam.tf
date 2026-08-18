module "iam" {
  source = "../../modules/iam"

  role_name   = "${var.project_name}-${var.environment}-task-role"
  policy_name = "${var.project_name}-${var.environment}-secrets-manager-policy"

  secret_arn = module.secrets_manager.secret_arn

  tags = local.common_tags
}
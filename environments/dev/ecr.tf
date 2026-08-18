module "ecr" {
  source = "../../modules/ecr"

  enabled = var.ecr_enabled

  project_name = var.project_name
  environment  = var.environment

  repository_name      = var.ecr_repository_name
  image_tag_mutability = var.ecr_image_tag_mutability
  scan_on_push         = var.ecr_scan_on_push

  force_delete = false

  tags = local.common_tags
}
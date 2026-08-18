module "s3" {
  source = "../../modules/s3"

  enabled            = var.s3_enabled
  bucket_name        = var.s3_bucket_name
  versioning_enabled = var.s3_versioning_enabled

  tags = local.common_tags
}
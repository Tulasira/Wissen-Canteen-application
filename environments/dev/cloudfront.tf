######################################################
# Origin Access Control
######################################################

module "cloudfront_origin_access_control" {
  source = "../../modules/cloudfront/origin-access-control"

  name = "${var.project_name}-${var.environment}-oac"
}

######################################################
# CloudFront Distribution
######################################################

module "cloudfront_distribution" {
  source = "../../modules/cloudfront/distribution"

  name = "${var.project_name}-${var.environment}-cdn"

  # domain_name              = var.acm_domain_name
  # certificate_arn          = module.acm.certificate_arn

  origin_domain_name       = module.s3.bucket_regional_domain_name
  origin_access_control_id = module.cloudfront_origin_access_control.id

  tags = local.common_tags
}

######################################################
# S3 Bucket Policy for CloudFront
######################################################

module "cloudfront_bucket_policy" {
  source = "../../modules/cloudfront/bucket-policy"

  bucket_id        = module.s3.bucket_id
  bucket_arn       = module.s3.bucket_arn
  distribution_arn = module.cloudfront_distribution.distribution_arn
}

######################################################
# CloudFront DNS Alias
######################################################

# module "cloudfront_dns_record" {
#   source = "../../modules/route53/record"

#   zone_id = module.route53_hosted_zone.zone_id
#   record_name            = var.acm_domain_name
#   alias_name             = module.cloudfront_distribution.distribution_domain_name
#   alias_zone_id          = module.cloudfront_distribution.distribution_hosted_zone_id
#   evaluate_target_health = false
# }

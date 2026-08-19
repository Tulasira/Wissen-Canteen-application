# ######################################################
# # ACM Certificate
# ######################################################

# module "acm" {
#   source = "../../modules/acm"

#   # providers = {
#   #   aws = aws.us_east_1
#   # }

#   name                      = "${var.project_name}-${var.environment}"
#   domain_name               = var.acm_domain_name
#   subject_alternative_names = var.acm_subject_alternative_names
#   route53_zone_id           = module.route53_hosted_zone.zone_id

#   tags = local.common_tags
# }

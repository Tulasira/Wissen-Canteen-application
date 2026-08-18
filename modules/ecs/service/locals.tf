locals {

  fargate_spot_weight = var.fargate_spot_percentage

  fargate_weight = (
    100 - var.fargate_spot_percentage
  )

}
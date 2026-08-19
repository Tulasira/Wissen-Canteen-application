variable "bucket_id" {
  description = "ID of the existing S3 origin bucket"
  type        = string
}

variable "bucket_arn" {
  description = "ARN of the existing S3 origin bucket"
  type        = string
}

variable "distribution_arn" {
  description = "ARN of the CloudFront distribution allowed to read the bucket"
  type        = string
}

variable "enabled" {
  description = "Enable or disable EBS Volume Attachment"
  type        = bool
}

variable "instance_id" {
  description = "EC2 Instance ID"
  type        = string
}

variable "volume_id" {
  description = "EBS Volume ID"
  type        = string
}

variable "device_name" {
  description = "Device name for attachment"
  type        = string
  default     = "/dev/sdf"
}

variable "force_detach" {
  description = "Force detach volume on destroy"
  type        = bool
  default     = false
}

variable "skip_destroy" {
  description = "Keep attachment during destroy"
  type        = bool
  default     = false
}
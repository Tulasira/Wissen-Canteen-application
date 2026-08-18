variable "enabled" {
  type = bool
}

variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "ami_id" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "key_name" {
  type = string
}

variable "security_group_ids" {
  type = list(string)
}

variable "iam_instance_profile" {
  type    = string
  default = null
}

variable "user_data" {
  type    = string
  default = ""
}

variable "ebs_optimized" {
  type    = bool
  default = false
}

variable "monitoring_enabled" {
  type    = bool
  default = true
}

variable "volume_size" {
  type = number
}

variable "volume_type" {
  type = string
}

variable "delete_on_termination" {
  type    = bool
  default = true
}

variable "encrypted" {
  type    = bool
  default = true
}

variable "spot_instance" {
  type = bool
}

variable "tags" {
  type = map(string)
}
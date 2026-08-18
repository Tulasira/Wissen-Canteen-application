variable "enabled" {
  type = bool
}

variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "traffic_type" {
  type = string
}

variable "retention_in_days" {
  type = number
}

variable "tags" {
  type = map(string)
}
variable "name_prefix" {
  type = string
}

variable "secret_arns" {
  description = "Map of secret name -> ARN the execution role needs read access to."
  type        = map(string)
}

variable "tags" {
  type    = map(string)
  default = {}
}

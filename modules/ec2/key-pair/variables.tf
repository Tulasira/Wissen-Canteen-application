variable "enabled" {
  type = bool
}

variable "create_key_pair" {
  description = "Create new key pair or use existing"
  type        = bool
  default     = true
}

variable "key_name" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "save_private_key" {
  description = "Save generated private key locally"
  type        = bool
  default     = true
}
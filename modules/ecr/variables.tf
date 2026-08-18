variable "name_prefix" {
  type = string
}

variable "keep_last_n_images" {
  type    = number
  default = 15
}

variable "tags" {
  type    = map(string)
  default = {}
}

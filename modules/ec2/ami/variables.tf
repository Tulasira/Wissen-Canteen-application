variable "os_type" {

  description = "Operating system"

  type = string

  default = "amazon-linux"

  validation {

    condition = contains(
      [
        "amazon-linux",
        "ubuntu"
      ],
      var.os_type
    )

    error_message = "Supported values are amazon-linux or ubuntu."

  }

}

variable "custom_ami_id" {

  description = "Custom AMI ID"

  type = string

  default = null

}
data "aws_ami" "amazon_linux" {
  count = (
    (var.custom_ami_id == null || var.custom_ami_id == "") &&
    var.os_type == "amazon-linux"
  ) ? 1 : 0

  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}

data "aws_ami" "ubuntu" {
  count = (
    (var.custom_ami_id == null || var.custom_ami_id == "") &&
    var.os_type == "ubuntu"
  ) ? 1 : 0

  most_recent = true

  owners = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

locals {

  ami_id = (
    var.custom_ami_id != null && var.custom_ami_id != ""
    ) ? var.custom_ami_id : (
    var.os_type == "ubuntu"
    ? data.aws_ami.ubuntu[0].id
    : data.aws_ami.amazon_linux[0].id
  )

}
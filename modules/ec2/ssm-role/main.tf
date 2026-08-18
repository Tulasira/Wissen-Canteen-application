########################################
# IAM Assume Role Policy
########################################

data "aws_iam_policy_document" "assume_role" {

  statement {

    effect = "Allow"

    principals {

      type = "Service"

      identifiers = [
        "ec2.amazonaws.com"
      ]

    }

    actions = [
      "sts:AssumeRole"
    ]

  }

}

########################################
# IAM Role
########################################

resource "aws_iam_role" "this" {

  count = var.enabled ? 1 : 0

  name = "${var.project_name}-${var.environment}-ssm-role"

  assume_role_policy = data.aws_iam_policy_document.assume_role.json

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-${var.environment}-ssm-role"
    }
  )

}

########################################
# Attach AmazonSSMManagedInstanceCore
########################################

resource "aws_iam_role_policy_attachment" "ssm" {

  count = var.enabled ? 1 : 0

  role = aws_iam_role.this[0].name

  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"

}
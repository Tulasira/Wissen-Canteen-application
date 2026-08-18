########################################
# EC2 Assume Role Policy
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

  name = "${var.project_name}-${var.environment}-ec2-role"

  assume_role_policy = data.aws_iam_policy_document.assume_role.json

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-${var.environment}-ec2-role"
    }
  )

}

########################################
# Instance Profile
########################################

resource "aws_iam_instance_profile" "this" {

  count = var.enabled ? 1 : 0

  name = "${var.project_name}-${var.environment}-instance-profile"

  role = aws_iam_role.this[0].name

}

########################################
# SSM Policy
########################################

resource "aws_iam_role_policy_attachment" "ssm" {
  count = var.enabled && var.attach_ssm_policy ? 1 : 0

  role       = aws_iam_role.this[0].name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

########################################
# CloudWatch Agent
########################################

resource "aws_iam_role_policy_attachment" "cloudwatch" {

  count = var.enabled && var.attach_cloudwatch_policy ? 1 : 0

  role = aws_iam_role.this[0].name

  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"

}

########################################
# ECR Read Only
########################################

resource "aws_iam_role_policy_attachment" "ecr" {

  count = var.enabled && var.attach_ecr_policy ? 1 : 0

  role = aws_iam_role.this[0].name

  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"

}

########################################
# S3 Read Only
########################################

resource "aws_iam_role_policy_attachment" "s3" {

  count = var.enabled && var.attach_s3_policy ? 1 : 0

  role = aws_iam_role.this[0].name

  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"

}

resource "aws_iam_role_policy_attachment" "additional" {
  count = var.enabled ? length(var.additional_policies) : 0

  role       = aws_iam_role.this[0].name
  policy_arn = var.additional_policies[count.index]
}
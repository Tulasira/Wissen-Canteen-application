resource "aws_iam_role" "task_role" {
  name = var.role_name

  assume_role_policy = file(
    "${path.module}/policies/ecs-task-trust-policy.json"
  )

  tags = var.tags
}

resource "aws_iam_policy" "secrets_manager" {
  name = var.policy_name

  policy = templatefile(
    "${path.module}/policies/secrets-manager-policy.json",
    {
      secret_arn = var.secret_arn
    }
  )

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "secrets_manager" {
  role       = aws_iam_role.task_role.name
  policy_arn = aws_iam_policy.secrets_manager.arn
}
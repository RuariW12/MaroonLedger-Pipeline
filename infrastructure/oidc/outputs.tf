output "role_arn" {
  description = "IAM role ARN for GitHub Actions"
  value       = aws_iam_role.github_actions.arn
}

output "ecr_repository_url" {
  description = "ECR repository URL for container image pushes"
  value       = aws_ecr_repository.app.repository_url

# MaroonLedger-Pipeline
Infrastructure-as-code for the Maroon Ledger cloud platform — a production-grade AWS deployment powering a mock banking application with full CI/CD automation.
Architecture
Traffic flows through the ALB in public subnets to ECS Fargate tasks running in private subnets across two availability zones. The frontend is served via CloudFront backed by a private S3 bucket using Origin Access Control. A NAT gateway provides outbound internet access for private subnet resources. All infrastructure is provisioned and managed through Terraform

## CI/CD Flow
GitHub Actions in the Maroon Ledger app repo authenticates to AWS via OIDC federation — no stored credentials. On every push to main:

Build — Docker image built and tagged with git SHA
Scan — Trivy vulnerability scan gates the pipeline on CRITICAL/HIGH findings
Push — Image pushed to ECR (immutable tags enforced)
Deploy — ECS task definition updated, service rolls out new revision
Frontend — React build synced to S3, CloudFront cache invalidated

## Security

OIDC federation — GitHub Actions assumes an IAM role via web identity, scoped to specific repos. No long-lived AWS credentials stored in GitHub.
Least-privilege IAM — GitHub Actions role scoped to ECR push, ECS deploy, S3 sync, CloudFront invalidation, and Secrets Manager read. ECS execution and task roles are separated.
Network isolation — Fargate tasks run in private subnets with no public IPs. Ingress restricted to ALB via security group references, not CIDR blocks. Database tier (future) only accepts traffic from ECS.
ECR image scanning — Scan-on-push enabled via Amazon Inspector. Immutable tags prevent image overwrites.
Trivy pipeline gate — CI/CD fails on critical or high severity CVEs before images reach production.

## Tech Stack
Terraform · AWS (VPC, ECS Fargate, ECR, ALB, S3, CloudFront, IAM, CloudWatch, Secrets Manager) · GitHub Actions · Docker · Trivy

* due to privacy and security concerns, some code has been rewritten to avoid ARN/credential leaks. In order to demonstrate workflows the files were kept but are not currently functional 

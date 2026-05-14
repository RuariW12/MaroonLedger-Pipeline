variable "project_name" {
  description = "Project name"
  type        = string
  default     = "maroon-ledger"
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-2"
}

variable "account_id" {
  description = "AWS account ID"
  type        = string
}

variable "github_org" {
  description = "GitHub organization or username"
  type        = string
  default     = "RuariW12"
}

variable "github_repo" {
  description = "GitHub repository name for the pipeline"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "app_port" {
  description = "Port the application container listens on"
  type        = number
  default     = 8000
}

variable "environment" {
  type        = string
  description = "Environment (aka k8s namespace)"
  
  validation {
    condition     = contains(["dev", "beta", "prod"], var.environment)
    error_message = "Environment should be one of [dev, beta, prod]."
  }
}
variable "provider_url" {
  default = "https://token.actions.githubusercontent.com"
  type    = string
}

variable "provider_client_list" {
  default = ["sts.amazonaws.com"]
  type    = list(string)
}

variable "provider_thumbprint_list" {
  default = ["22ff89586561fc2d52f77491e9f1eff1b80be33e"]
  type    = list(string)
}

variable "tags" {
  type = map(string)
  default = {
    "identity" = "github"
  }
}

variable "role_name" {
  default = "github-oidc-role-deployer"
  type    = string
}

variable "role_description" {
  default = ""
  type    = string
}

variable "max_session_duration" {
  default     = 3600
  type        = number
  description = "Maximum session duration (in seconds)"
}

variable "repositories" {
  type = list(string)
}

variable "role_attach_policy_arn" {
  description = "IAM Role ARN to attach to this role"
  type        = string
  default     = ""
}

variable "policy_condition_test" {
  type        = string
  default     = "StringEquals"
  description = "should be StringEquals or StringLike"
}

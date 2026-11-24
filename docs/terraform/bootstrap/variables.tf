variable "tenant_id" {
  description = "Entra ID tenant ID. Pinned so applies cannot hit the wrong tenant."
  type        = string
}

variable "subscription_id" {
  description = "Subscription containing the Terraform state storage account"
  type        = string
}
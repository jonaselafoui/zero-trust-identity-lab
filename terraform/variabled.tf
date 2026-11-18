variable "tenant_id" {
  description = "Entra ID tenant ID. Pinned so applies cannot hit the wrong tenant."
  type        = string
}

variable "guest_users" {
  type = list(string)
}
variable "policy_name" {
  description = "The name of the Azure Policy Definition"
  type        = string
}

variable "client_id" {
  description = "The user id of the Service Principal identity that terraform will run under"
  type        = string
}

variable "client_secret" {
  description = "The password/client_secret of the Service Principal identity that terraform will run under"
  type        = string
}

variable "tenant_id" {
  description = "The tenant id of the Service Principal identity that terraform will run under"
  type        = string
}

variable "subscription_id" {
  description = "The subscription id of that is in scope for this Azure Policy Definition"
  type        = string
}
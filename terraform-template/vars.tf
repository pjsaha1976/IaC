variable "prefix" {
  description = "Prefix for all resources"
  type        = string
  default     = "demo"
}

variable "location" {
  description = "Azure region for resources"
  type        = string
  default     = "East US"
}

variable "admin_password" {
  description = "Admin password for the VM"
  type        = string
  sensitive   = true
}

variable "vm_count" {
  description = "Number of virtual machines to deploy"
  type        = number
  default     = 1
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
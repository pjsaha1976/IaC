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
variable "vnet_name" {
  description = "Name of the vnet to create"
  type        = string
  default     = "smgr-vnet"
}

variable "resource_group_location" {
  description = "locatio of the resource group to be created."
  type        = string
  default     = ""
}

variable "resource_group_name" {
  description = "Name of the resource group to be created."
  type        = string
  default     = "rg-p-vnet0101"
}

variable "address_space" {
  type        = list(string)
  description = "The address space that is used by the virtual network."
  default     = ["10.2.0.0/16"]
}
variable "subnet_names" {
  description = "A list of public subnets inside the vNet."
  type        = string
  default     = ""
}
variable "vnet_location" {
  description = "The location of the vnet to create. Defaults to the location of the resource group."
  type        = string
  default     = ""
}
variable "prefix" {
  description = "The location of the vnet to create. Defaults to the location of the resource group."
  type        = string
  default     = "smgr"

}

variable "admin_password" {
  description = "password to newly created VM."
  type        = string

}
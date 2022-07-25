variable "customername" {
  type = string
}

variable "location" {
  type = string
  default = "eastus2"
}
variable "tags" {
  description = "value"
  type        = map(string)
}
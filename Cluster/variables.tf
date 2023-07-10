variable "location" {
   type = string
   description = "Region"
   default = "westeurope"
}
variable "ansible_host" {
  type = string
  default = "master ansible_host="
}
#variable "ansible_username" {
#   type = string
#   default = "ansible_user="
#}
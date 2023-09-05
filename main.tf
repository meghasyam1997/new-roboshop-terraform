variable "my_value" {
  default = "syam"
}

output "out" {
  value = var.my_value
}
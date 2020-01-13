variable "environment" {
  description = "environment slug"
  type        = string
}

variable "password" {
  description = "master password for the database instance"
  type        = string
}

variable "vpc_id" {
  description = "id of the vpc to use"
  type        = string
}

variable "subnet_group" {
  description = "subnet security group"
  type        = string
}
variable "region" {
  description = "location jakarta"
  type        = string
  default     = "ap-southeast-3"
}

variable "availability_zones" {
  description = "The az that the resources will be launched"
  #default = ["${var.region}a", "${var.region}b", "${var.region}c"]
  default = ["ap-southeast-3a", "ap-southeast-3b", "ap-southeast-3c"]
}

variable "environment" {
  description = "env variables"
  type        = string
}

//Networkiung
variable "vpc_cidr" {
  description = "The CIDR block of the vpc"
}

variable "public_subnets_cidr" {
  type        = list
  description = "The CIDR block for the public subnet"
}

variable "private_subnets_cidr" {
  type        = list
  description = "The CIDR block for the private subnet"
}


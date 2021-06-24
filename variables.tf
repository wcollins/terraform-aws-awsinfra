variable "vpc_name" {
  description = "VPC name"
  type        = string
}

variable "instance_names" {
  description = "List of EC2 instances"
  type        = list(string)
}

variable "subnet_names" {
  description = "List of subnet names"
  type        = list(string)
}

variable "vpc_prefix" {
  description = "VPC address space"
  type        = string
}

variable "subnet_prefixes" {
  description = "List of subnet prefixes"
  type        = list(string)
}

variable "vpc_tags" {
  description = "VPC tags"
  type        = map(string)
  default     = {}
}

variable "subnet_tags" {
  description = "Subnet tags"
  type        = map(string)
  default     = {}
}

variable "instance_type" {
  description = "Instance type"
  type        = string
  default     = "t2.micro"
}

variable "ssh_key" {
  description = "Public key content"
  type        = string
}

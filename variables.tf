variable "company" {
  type        = string
  description = "Compmay Name"
  default     = "fahim-test"
}

variable "project" {
  type        = string
  description = "project Name"
  default     = "sandbox"
}

variable "billing_code" {
  type        = string
  description = "Billing Code"
  default     = "FH"
}

variable "aws_region" {
  type        = string
  description = "Region for AWS Resources"
  default     = "ap-southeast-1"
}

variable "vpc_cidr_range" {
  type        = string
  description = "Base CIDR Block for VPC"
}

variable "enable_dns_hostnames" {
  type        = bool
  description = "Enable DNS hostnames in VPC"
  default     = true
}

variable "map_public_ip_on_launch" {
  type        = bool
  description = "Map a public IP address for Subnet instances"
  default     = true
}

variable "vpc_subnet_count" {
  type        = number
  description = "No of subnet in VPC"
  default     = 2
}

variable "naming_prefix" {
  type = string
  description = "Name prefix"
  default = "connect2ocbc"
}

variable "ami_id" {
  type = string
  description = "Amazon machine Id"
  default = "ami-076349d135332cba8"
}

variable "external_web_instance_count" {
  type = number
  description = "No of external web server"
  default = 1
}

variable "internal_web_instance_count" {
  type = number
  description = "No of Internal web server"
  default = 1
}

variable "instance_type" {
  type = string
  description = "Ec2 instance type"
  default = "t2.micro"
}

variable "keypair_name" {
  type = string
  description = "keypair name"
  default = "mykeypair"
}
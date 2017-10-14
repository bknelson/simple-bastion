variable "ami_id" {
  type = "string"
  description = "AMI ID for bastion instance"
  default = "ami-e689729e"
}

variable "ssh_key_name" {
  type = "string"
  description = "Key for default user"
}

variable "subnet_list" {
  type = "string"
  description = "Comma delimited list of subnets for location of bastion"
}

variable "user_ip" {
  type = "string"
  description = "User's IP"
}

variable "name" {
  type = "string"
  description = "Name suffix for bastion"
}

variable "zone_name" {
  type = "string"
  description = "Rt 53 zone name"
}

variable "region" {
  type = "string"
  description = "AWS region to use"
  default = "us-west-2"
}
variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_key_path" {}
variable "aws_key_name" {}

variable "aws_region" {
    description = "EC2 Region for the VPC"
    default = "eu-west-1"
}

variable "amis" {
    description = "AMIs by region"
    default = {
        eu-west-1 = "ami-055958ae2f796344b" # ubuntu 14.04 LTS
    }
}

variable "instance_type" {
    description = "Type of instance used"
    default = "m1.small"
}

variable "vpc_cidr" {
    description = "CIDR for the whole VPC"
    default = "10.0.0.0/16"
}

variable "public_subnet_cidr_1a" {
    description = "CIDR for the Public Subnet"
    default = "10.0.0.0/24"
}

variable "private_subnet_cidr_1a" {
    description = "CIDR for the Private Subnet"
    default = "10.0.1.0/24"
}

variable "public_subnet_cidr_1b" {
    description = "CIDR for the Public Subnet"
    default = "10.1.0.0/24"
}

variable "private_subnet_cidr_1b" {
    description = "CIDR for the Private Subnet"
    default = "10.1.1.0/24"
}

variable "ssh_key_name" {
    description = "SSH Public Key for bastion host connection"
    default =  ""
} 
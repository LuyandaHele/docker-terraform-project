# Enviroment Variables
variable "region" {
    description = "The AWS region to deploy resources in"
    type        = string
}


variable "project_name" {
    description = "project name"
    type        = string
}

variable "environment" {
    description = "environment "
    type        = string
}
# vpc variables
variable "vpc_cidr" {
    description = "VPC CIDR block"
    type        = string
}

# vpc public subnet 1 variables
variable "public_subnet_az1_cidr" {
    description = "Public Subnet CIDR block for AZ1"
    type        = string
}

# vpc public subnet 2 variables
variable "public_subnet_az2_cidr" {
    description = "Public Subnet CIDR block for AZ2"
    type = string 
}

# vpc private app subnet 1 variables
variable "private_app_subnet_az1_cidr" {
    description = "Private Subnet CIDR block for AZ1"
    type = string 
}

# vpc private app subnet 2 variables
variable "private_app_subnet_az2_cidr" {
    description = "Private Subnet CIDR block for AZ2"
    type = string
}

# vpc private data subnet 1 variables
variable "private_data_subnet_az1_cidr" {
    description = "Private Data Subnet CIDR block for AZ1"
    type = string 
}

# vpc private data subnet 2 variables
variable "private_data_subnet_az2_cidr" {
    description = "Private Data Subnet CIDR block for AZ2"
    type = string 
}
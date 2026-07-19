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

# security groups variable
variable "ssh_location" {
    description = "ip address that can ssh into the servers"
    type = string 
}

# rds variable for snapshot identifer
variable "database_snapshot_identifier" {
    description = "database snapshot name"
    type = string
}

# rds variables for database instance class 
variable "database_instance_class" {
    description = "database instance type"
    type = string
}

# rds variables for database instance identifer
variable "database_instance_identifier" {
    description = "database instance identifer"
    type = string
}

# rds variables for database instance identifer
variable "multi_az_deployment" {
    description = "create a standby db instance"
    type = bool
    default = false
}

# rds other additional variables
variable "database_engine"{
    type = string
    default = "PostgreSQL"
}

variable "database_engine_version"{
    type = string
}

variable "database_allocated_storage"{
    type = number 
    default = 20
}

variable "database_username"{
    type = string
}

variable "database_password"{
    type = string 
    sensitive = true
}

variable "database_name"{
    type = string
}

#s3 bucket
 
variable "env_bucket_name"{
    description = "s3 bucket name"
    type = string 
}

variable "env_file_name"{
    description = "s3 bucket env name"
    type = string 
}

# ecs variables
variable "architecture"{
    description = "ecs cpu architecture"
    type = string 
}

# image varibales
variable "container_image"{
    description = "cotnainer image uri"
    type = string 
}




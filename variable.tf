variable "region" {
  type        = string
  description = "AWS region where resources will be deployed"
  default     = "ca-central-1"
}

variable "ami" {
  type        = string
  description = "AMI ID for EC2 instances"
  default     = "ami-029c5475368ac7adc"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type"
  default     = "t2.micro"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR range for the VPC"
  default     = "10.40.0.0/16"
}

variable "subnet1_cidr" {
  type        = string
  description = "CIDR range for Subnet 1 (AZ1)"
  default     = "10.40.1.0/24"
}

variable "subnet2_cidr" {
  type        = string
  description = "CIDR range for Subnet 2 (AZ1)"
  default     = "10.40.2.0/24"
}

variable "subnet3_cidr" {
  type        = string
  description = "CIDR range for Subnet 3 (AZ2)"
  default     = "10.40.3.0/24"
}

variable "subnet4_cidr" {
  type        = string
  description = "CIDR range for Subnet 4 (AZ2)"
  default     = "10.40.4.0/24"
}

variable "AZ1" {
  type        = string
  description = "Availability Zone 1"
  default     = "ca-central-1a"
}

variable "AZ2" {
  type        = string
  description = "Availability Zone 2"
  default     = "ca-central-1b"
}
variable "db_name" {
  default     = "appdb"
  description = "Database name"
}
variable "db_instance_class" {
  description = "RDS instance class type"
  type        = string
  default     = "db.t3.micro"
}

variable "db_engine" {
  description = "Database engine type"
  type        = string
  default     = "mysql"
}
variable "db_port" {
  description = "Database port number"
  type        = number
  default     = 3306
}
variable "db_username" {
  description = "username for the RDS database"
  type        = string
  default     = "adminuser"
}

variable "db_password" {
  description = "password for the RDS database"
  type        = string
  default     = "root1234"
}


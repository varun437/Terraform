variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_region" {}
//vpc
variable "vpc_cidr" {}
variable "vpc_name" {}
variable "environment" {}
//public-subnet
variable "public_subnet1_cidr" {}
variable "public_subnet1_name" {}
//private-subnet
variable "private_subnet1_cidr" {}
variable "private_subnet1_name" {}
//public-route-table
variable "Main_Routing_Table" {}
//private-route-table
variable "Private_Main_Routing_Table" {}
//internet-gateway
variable "IGW_name" {}

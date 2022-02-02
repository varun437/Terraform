provider "aws" {
    access_key = "${var.aws_access_key}"
    secret_key = "${var.aws_secret_key}"
    region = "${var.aws_region}"
}

terraform {
  required_version = "<= 0.14" #Forcing which version of Terraform needs to be used
  required_providers {
    aws = {
      version = "<= 3.0.0" #Forcing which version of plugin needs to be used.
      source = "hashicorp/aws"
    }
  }
}
//VPC
resource "aws_vpc" "main" {
    cidr_block = "${var.vpc_cidr}"
    enable_dns_hostnames = true
    tags = {
        Name = "${var.vpc_name}"
	environment = "${var.environment}"
    }
}
//PUBLIC-SUBNET
resource "aws_subnet" "subnet1-public" {
    vpc_id = "${aws_vpc.main.id}"
    cidr_block = "${var.public_subnet1_cidr}"
    availability_zone = "us-east-1a"

    tags = {
        Name = "${var.public_subnet1_name}"
    }
}
//PRIVATE-SUBNET
resource "aws_subnet" "subnet1-private" {
    vpc_id = "${aws_vpc.main.id}"
    cidr_block = "${var.private_subnet1_cidr}"
    availability_zone = "us-east-1a"

    tags = {
        Name = "${var.private_subnet1_name}"
    }
}

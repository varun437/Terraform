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
    map_public_ip_on_launch = true

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

//PUBLIC-ROUTE-TABLE
resource "aws_route_table" "public-route-table" {
    vpc_id = "${aws_vpc.main.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.main-igw.id}"
    }

    tags = {
        Name = "${var.Main_Routing_Table}"
    }
}
//PUBLIC-ROUTE-TABLE-SUBNET-ASSOCIATION
resource "aws_route_table_association" "public-subnet-association" {
    subnet_id = "${aws_subnet.subnet1-public.id}"
    route_table_id = "${aws_route_table.public-route-table.id}"
}

//PRIVAYE-ROUTE-TABLE
resource "aws_route_table" "private-route-table" {
    vpc_id = "${aws_vpc.main.id}"

    tags = {
        Name = "${var.Private_Main_Routing_Table}"
    }
}
//PRIVATE-ROUTE-TABLE-SUBNET-ASSOCIATION
resource "aws_route_table_association" "private-subnet-association" {
    subnet_id = "${aws_subnet.subnet1-private.id}"
    route_table_id = "${aws_route_table.private-route-table.id}"
}

//INTERNET-GATEWAY
resource "aws_internet_gateway" "main-igw" {
    vpc_id = "${aws_vpc.main.id}"
	tags = {
        Name = "${var.IGW_name}"
    }
}

//SECURITY-GROUP
resource "aws_security_group" "allow_all" {
  name        = "Terra-SG"
  description = "Allow all inbound traffic"
  vpc_id      = "${aws_vpc.main.id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
    }
}

//EC2
resource "aws_instance" "server" {
  ami           = "${var.ami_id}"
  subnet_id = "${aws_subnet.subnet1-public.id}"
  instance_type = "${var.instance_type}"
  key_name = "${var.key}"

  tags = {
    Name = "Dev"
  }
}

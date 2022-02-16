#enter access key and secret key
aws_access_key = "ACCESS-KEY"
aws_secret_key = "SECRET-KEY"

//VPC
#enter a region
aws_region = "us-east-1"
#enter vpc-name
vpc_name = "aws-terra"
#enter vpc-cidr
vpc_cidr = "10.50.0.0/16"
#enter tag-value 
environment = "dev"

//PUBLIC-SUBNET
#enter subnet-cidr
public_subnet1_cidr = "10.50.1.0/24"
#enter subnet-name
public_subnet1_name = "PublicSubnet-1"

//PRIVATE-SUBNET
#enter subnet-cidr
private_subnet1_cidr = "10.50.2.0/24"
#enter subnet-name
private_subnet1_name = "Privatesubnet-1"

//PUBLIC-ROUTE-TABLE
#enter public route table name
Main_Routing_Table = "Public-RT"

//PRIVATE-ROUTE-TABLE
#enter private route table name
Private_Main_Routing_Table = "Private-RT"

//INTERNET-GATEWAY
#enter the name of IGW
IGW_name = "terra-IGW"

//EC2
#enter the ami-id
ami_id ="ami-038b3df3312ddf25d"
#enter the instance-type
instance_type="t2.micro"
#enter the key-pair
key = "KEY-NAME"

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider

provider "aws" {
  region     = "us-east-1"
  access_key = "AKIARMGMXWTSRZUTRJDG"
  secret_key = "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"
}

# create Ec2 Instance 
resource "aws_instance" "myec2" {
  ami           = "ami-0889a44b331db0194"
  instance_type = "t2.micro"
  subnet_id     = "terraformsubnet"
  
 

  tags = {
    Name = "Terra_instance"
  }
}

# Create a VPC
resource "aws_vpc" "terraformvpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "terraformvpc"
  }
}

# create a subnet
resource "aws_subnet" "terraformsubnet" {
  vpc_id     = aws_vpc.terraformvpc.id
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "terraformsubnet"
  }
}

# create internet gateway
resource "aws_internet_gateway" "igwterraform" {
  vpc_id = aws_vpc.terraformvpc.id

  tags = {
    Name = "igwterraform"
  }
}

# Create Route table
resource "aws_route_table" "terraformRT" {
  vpc_id = aws_vpc.terraformvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igwterraform.id
  }
  tags = {
    Name = "terraformRT"
  }
}

# create subnet associate
resource "aws_route_table_association" "subassociate" {
  subnet_id      = aws_subnet.terraformsubnet.id
  route_table_id = aws_route_table.terraformRT.id
}

# create security group
resource "aws_security_group" "terraformSecGroup" {
  name        = "terraformSecGroup"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.terraformvpc.id

  ingress {
    description      = "TLS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.terraformvpc.cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "terraformSecGroup"
  }
}



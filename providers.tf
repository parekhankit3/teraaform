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
  region     = "us-west-2"
  access_key = "AKIARMGMXWTSRZUTRJDG"
  secret_key = "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"
}
# Create a VPC
resource "aws_vpc" "terraVpc" {
  cidr_block = "10.0.0.0/16"
}

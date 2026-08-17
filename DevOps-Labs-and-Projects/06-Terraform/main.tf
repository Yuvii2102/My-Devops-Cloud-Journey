terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "my_ec2" {
  ami           = "ami-0c2b8ca1dad447f8a"
  instance_type = "t3.micro"

  tags = {
    Name = "Terraform-EC2"
  }
}


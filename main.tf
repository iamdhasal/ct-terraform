terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.72.0"
    }
  }
}
variable "aws_access_key" {}
variable "aws_secret_key" {}

provider "aws" {
  region     = "us-east-1"
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  
}

resource "aws_instance" "nginx_webserver" {
  ami           = "ami-04505e74c0741db8d"
  instance_type = "t2.micro"
  user_data     = file("install_nginx.sh")

  tags = {
    Name = "nginx_webserver"
  }
}

resource "aws_security_group" "nginx_sg" {
  name        = "nginx_sg"
  vpc_id      = "vpc-06c65f160dd24c1ba"

  ingress {
    description = "TLS from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }
  ingress {
    description = "SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "nginx_sg"
  }
}
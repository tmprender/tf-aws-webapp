terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
    hcp = {
      source  = "hashicorp/hcp"
      version = "~> 0.44.0"
    }
  }
}

provider "aws" {
  region = var.region
}

resource "aws_vpc" "hashiapp" {
  cidr_block           = var.address_space
  enable_dns_hostnames = true

  tags = {
    name        = "${var.prefix}-vpc-${var.region}"
    environment = "Production"
  }
}

resource "aws_subnet" "hashiapp" {
  vpc_id     = aws_vpc.hashiapp.id
  cidr_block = var.subnet_prefix

  tags = {
    name = "${var.prefix}-subnet"
  }
}

resource "aws_security_group" "hashiapp" {
  name = "${var.prefix}-security-group"

  vpc_id = aws_vpc.hashiapp.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
    prefix_list_ids = []
  }

  tags = {
    Name = "${var.prefix}-security-group"
  }
}

resource "aws_internet_gateway" "hashiapp" {
  vpc_id = aws_vpc.hashiapp.id

  tags = {
    Name = "${var.prefix}-internet-gateway"
  }
}

resource "aws_route_table" "hashiapp" {
  vpc_id = aws_vpc.hashiapp.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.hashiapp.id
  }
}

resource "aws_route_table_association" "hashiapp" {
  subnet_id      = aws_subnet.hashiapp.id
  route_table_id = aws_route_table.hashiapp.id
}

data "hcp_packer_iteration" "ubuntu" {
  bucket_name = "ubuntu-focal-webserver"
  channel     = "production"
}

data "hcp_packer_image" "ubuntu" {
  bucket_name    = "ubuntu-focal-webserver"
  cloud_provider = "aws"
  iteration_id   = data.hcp_packer_iteration.ubuntu.ulid
  region         = var.region
}

resource "aws_instance" "hashiapp" {
  ami                         = data.hcp_packer_image.ubuntu.cloud_image_id
  instance_type               = var.instance_type
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.hashiapp.id
  vpc_security_group_ids      = [aws_security_group.hashiapp.id]
  user_data                   = file("./user_data.sh")

  tags = {
    Name = "${var.prefix}-hashiapp-instance"
  }
}

provider "aws" {
    region = "us-west-2"
}

variable "subnet_cidr_block" {
    description = "subnet_cidr_block"
}

variable "vpc_cidr_block" {
    description = "vpc_cidr_block"
    type = string
}

variable "cidr_blocks" {
    description = "cidr blocks for vpc and subnets"
    type = list(object({
        cidr_block = string
        name = string
    }))
}

variable "environment" {
    description = "deployment environment"
}

resource "aws_vpc" "developement-vpc"{
    cidr_block = var.cidr_blocks[0].cidr_block
    tags = {
        Name : var.cidr_blocks[0].name
    }
}

resource "aws_subnet" "development-subnet-1" {
    vpc_id = aws_vpc.developement-vpc.id
    cidr_block = var.cidr_blocks[1 ].cidr_block
    availability_zone = "us-west-2a"
    tags = {
        Name : var.cidr_blocks[1].name
    }
}

data "aws_vpc" "existing-vpc" {
    default = true
}

resource "aws_subnet" "dev-subnet-2" {
    vpc_id = data.aws_vpc.existing-vpc.id
    cidr_block = "172.31.64.0/20"
    availability_zone = "us-west-2a"
    tags = {
        Name : "subnet-2-dev"
    }
}

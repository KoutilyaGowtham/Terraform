variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_key_path" {}
variable "aws_key_name" {}
variabe "region" {
  default = "us-east-1"
  }
variable "aws_ami_nat" {
             default = "ami-2e1bc047"
}
variable "aws_ubuntu_ami" {
             default = "ami-b227efda"
}
variable "aws_instance_type" {
          default = "t2.micro"
  }
variable "aws_availabilty_zone" {
      default = "us-east-1"
  }
variable "cidr_block" {
  default = "10.0.0.0/16"
  }

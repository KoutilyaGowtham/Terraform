provider "aws" {
        access_key = "${var.aws_access_key}"
        secret_key = "${var.aws_secret_key}"
        region = "us-east-1"
        
}

resource "aws_vpc" "default" {
        cidr_block = "10.0.0.0/16"
        
}

resource "aws_internet_gateway" {
        vpc_id = "${aws_vpc.default.id}"
        
}

resource "aws_security_group" "nat" {
        name = "nat"
        description = "Allowing the internet access to private subnets through NAT Gateway"
        
        ingress {
                from_port = 0
                to_port = 65535
                protocol ="tcp"
                cidr_block = "${aws_subnet.us-east-1b-private.cidr_block}"
                }
        ingress {
                from_port = 0
                to_port = 65535
                protocol = "tcp"
                cidr_block = "${aws_subnet.us-east-1d-private.cidr_block}"
                }
        }

resource "aws_instance" "nat" {
        ami = "${var.aws_ami_nat}"
        instance_type = "${var.aws_instance_type}"
        availability_zone = "${var.aws_availabilty_zone}"
        key_name = "${var.aws_key_name}"
        security_groups = "${aws_security_group.nat.id}"
        subnet_id = "${aws_subnet.us-east-1b-public.id}"
        associate_public_ip_address = true
        source_dest_check = false
}

resource "aws_eip" "nat" {
        instance_id = "${aws_intance.nat.id}"
        vpc = true
        }

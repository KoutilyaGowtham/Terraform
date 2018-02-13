provider "aws" {
        access_key = "${var.aws_access_key}"
        secret_key = "${var.aws_secret_key}"
        region = "${var.region}"
        
}

resource "aws_vpc" "default" {
        cidr_block = "${var.cidr_block}"
        
}

resource "aws_internet_gateway" "default" {
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
        availability_zone = "us-east-1b"
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

resource "aws_route_table" "public_route_table" {
        vpc_id = "${aws_vpc.default.id}"
        route {
                cidr_block = "0.0.0.0/16"
                gateway_id = "${aws_internet_gateway.default.id}"
                }
        }

# Creating the public subnets
resource "aws_subnets" "public-1b" {
        vpc_id = "${aws_vpc.default.id}"
        cidr_block = "10.0.0.0/24"
        availability_zone = "us-east-1b"
        }

resource "aws_subnet" "public-1d" {
        vpc_id = "${aws_vpc.default.id}"
        cidr_block = "10.0.2.0/24"
        availability_zone = "us-east-1d"
        }

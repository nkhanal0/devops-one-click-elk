#Configure the AWS Provider
provider "aws" {
  version = "~> 2.0"
  region = "${var.region}"
}

# Create a VPC
resource "aws_vpc" "main" {
  cidr_block = "${var.vpc_cidr}"
}

# Create an Internet Gateway attached to the VPC
resource "aws_internet_gateway" "main" {
  vpc_id = "${aws_vpc.main.id}"
}

# Create a Subnet
resource "aws_subnet" "public" {
  vpc_id = "${aws_vpc.main.id}"
  cidr_block = "${var.public_subnet_cidr}"
  availability_zone = "${var.public_subnet_az}"
}

# Create Security Group to allow traffic to the instances
resource "aws_security_group" "sg_elk" {
  name = "sg_for_elk_stack"
  vpc_id = "${aws_vpc.main.id}"
  description = "Allow Connections to Kibana, Jenkins, Elasticsearch"

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks =  ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks =  ["0.0.0.0/0"]
  }

  ingress {
    from_port = 5601
    to_port = 5601
    protocol = "tcp"
    cidr_blocks =  ["0.0.0.0/0"]
  }
  ingress {
    from_port = 9200
    to_port = 9200
    protocol = "tcp"
    cidr_blocks =  ["0.0.0.0/0"]
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = "${aws_vpc.main.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.main.id}"
  }
}

resource "aws_route_table_association" "elk-rtb" {
  subnet_id = "${aws_subnet.public.id}"
  route_table_id = "${aws_route_table.public_route_table.id}"
}

resource "aws_instance" "jenkins" {
  key_name = "${var.jenkins_key_name}"
  ami = "${var.jenkins_ami_id}"
  instance_type = "${var.jenkins_instance_type}"
  subnet_id ="${aws_subnet.public.id}"
  associate_public_ip_address="true"
  vpc_security_group_ids=["${aws_security_group.sg_elk.id}"]
  root_block_device= {
    volume_type = "${var.jenkins_volume_type}"
    volume_size = "${var.jenkins_volume_size}"
  }
}

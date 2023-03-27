provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region = "us-east-1"
}

#Create New VPC
resource "aws_vpc" "ec2_vpc" {
  cidr_block = "10.0.0.0/16"
}

#Create New Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.ec2_vpc.id
}

#Create New Route Table
resource "aws_route_table" "rtb_public" {
  vpc_id = aws_vpc.ec2_vpc.id
route {
      cidr_block = "0.0.0.0/0"
      gateway_id = "${aws_internet_gateway.igw.id}"
  }
}

#Create New Subnet
resource "aws_subnet" "ec2_subnet" {
  vpc_id     = aws_vpc.ec2_vpc.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
}

#Associate Route Table to Subnet
resource "aws_route_table_association" "rta_subnet_public" {
  subnet_id      = "${aws_subnet.ec2_subnet.id}"
  route_table_id = "${aws_route_table.rtb_public.id}"
}

//#Create an New Elastic IP
//resource "aws_eip" "ec2-eip" {
//  vpc = true
//}

#Create New Security Group
resource "aws_security_group" "ec2_security_group" {
  name_prefix = "ec2_sg"
  description = "Allow Allinbound traffic for Testing/Demo"
  vpc_id      = aws_vpc.ec2_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#Create Key Pair using our pub key
resource "aws_key_pair" "ec2_linux_keypair" {
  key_name   = "ec2_linux_keypair"
  public_key = "${file(var.public_key_path)}"
}

#Create EC2 instance
resource "aws_instance" "ec2_instance" {
  ami           = "${var.ami_id}"
//  count         = "${var.number_of_instances}"
  instance_type = "${var.instance_type}"
  subnet_id     = aws_subnet.ec2_subnet.id

  vpc_security_group_ids = [
    aws_security_group.ec2_security_group.id,
  ]

  key_name = aws_key_pair.ec2_linux_keypair.key_name

  tags = {
    Name = "ec2-linux-instance"
  }
}

//#Associate EIP with EC2 Instance
//resource "aws_eip_association" "ec2-eip-association" {
//  instance_id   = aws_instance.ec2_instance.id
//  allocation_id = aws_eip.ec2-eip.id
//}

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

#Create New Security Group
resource "aws_security_group" "ec2_security_group" {
  name_prefix = "ec2_sg"
  description = "Allow Allinbound traffic for Testing/Demo"
  vpc_id      = aws_vpc.ec2_vpc.id

  # Ensure the VPC has been created before creating the security group
  depends_on = [aws_vpc.ec2_vpc]

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
  count         = "${var.number_of_instances}"
  instance_type = "${var.instance_type}"
  subnet_id     = aws_subnet.ec2_subnet.id

  vpc_security_group_ids = [
    aws_security_group.ec2_security_group.id,
  ]

  depends_on = [
    aws_security_group.ec2_security_group,
  ]
  
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("~/.ssh/id_rsa")
    host        = aws_instance.ec2_instance[0].public_ip
  }

  # To Update System and isntall nginx using remote-exec provisioner
  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y nginx",
      "sudo service nginx start",
    ]
  }

  # Wait for the Port 80 to connect via security group
  provisioner "local-exec" {
    command = "until nc -zv ${aws_instance.ec2_instance[0].public_ip} 80; do sleep 10; done"
  }

  key_name = aws_key_pair.ec2_linux_keypair.key_name

  tags = {
    Name = "ec2-linux-instance"
  }
}

resource "aws_s3_bucket" "sravanec2bucket" {
  bucket = "sravanec2bucket"

  tags = {
    Name        = "sravanec2bucket"
    Environment = "dev"
  }
}

resource "aws_s3_bucket_ownership_controls" "sravanec2bucket" {
  bucket = aws_s3_bucket.sravanec2bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "sravanec2bucket" {
  depends_on = [aws_s3_bucket_ownership_controls.sravanec2bucket]

  bucket = aws_s3_bucket.sravanec2bucket.id
  acl    = "private"
}

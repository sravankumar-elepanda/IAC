variable "access_key" {
        description = "Access key to AWS console"
}
variable "secret_key" {
        description = "Secret key to AWS console"
}

variable "instance_name" {
        description = "Name of the instance to be created"
        default = "terra-ec2-test"
}

variable "instance_type" {
        description = "type for aws EC2 instance"
        default = "t2.micro"
}

//variable "subnet_id" {
//        description = "The VPC subnet the instance(s) will be created in"
//        default = "subnet-07ebbe60"
//}

variable "ami_id" {
        description = "AMI for aws EC2 instance"
       ## Ubuntu AMI 
        default = "ami-09d56f8956ab235b3"
       ## Windows AMI 
       ## default = "ami-0e38fa17744b2f6a5"
}

variable "number_of_instances" {
        description = "number of instances to be created"
        default = 1
}

variable "public_key_path" {
        description = "Public key path"
       // For ubuntu 
        default = "~/.ssh/id_rsa.pub"
       // For Windows
       //default = "/Users/mohan/Downloads/win-pem.pub"
}

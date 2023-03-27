We are going to create all these resources with Terraform. Let’s list out all resources to be created for running EC2 instance inside a virtual private network as that helps us in better understanding.

1.	VPC
2.	Subnet inside VPC
3.	Internet gateway associated with VPC
4.	Route Table inside VPC with a route that directs internet-bound traffic to the internet gateway
5.	Route table association with our subnet to make it a public subnet
6.	Security group inside VPC
7.	Key pair used for SSH access
8.	EC2 instance inside our public subnet with an associated security group and a generated key pair

As we have a clear picture of what resources we need to create for our production environment with EC2, we can try and identify some of our inputs as variables so that they are easily changed and maintained.

1.	CIDR block for VPC
2.	CIDR block for subnet which is a subset of CIDR block of VPC
3.	Availability zone which is used to create our subnet
4.	The public key path which is used in Key pair creation
5.	AMI which is used to create EC2 instance
6.	Instance type of EC2 instance
7.	With AWS, we can start adding tags to track our resources. We are using environment tag.

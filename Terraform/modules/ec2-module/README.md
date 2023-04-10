This Terraform module provisions an EC2 instance in AWS. It allows you to customize the instance by providing input variables such as instance type, AMI ID, subnet ID, and security group ID.

**Usage**
To use this module, You can clone and run terraform plan/apply against aws-ec2.tf 

You can customize the input variables as per your requirement.

**Input Variables**
- instance_type: The type of EC2 instance to launch.
- ami_id: The ID of the Amazon Machine Image (AMI) to use for the instance.
- subnet_id: The ID of the subnet in which to launch the instance.
- security_group_id: The ID of the security group to associate with the instance.

**Outputs**
- instance_id: The Instnace ID of the instnace.
- public_ip: The public IP address of the instance.


**Contributing**
Contributions are welcome! Feel free to open an issue or submit a pull request.

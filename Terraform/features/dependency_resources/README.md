This repository contains sample code and configuration files used in the video tutorial ["Terraform Avengers: Assembling the Key Features of Count, Depends_on, and Provisioner for Epic Infrastructure Management".](https://youtu.be/YvNvyR3VDsY) In this tutorial, we explore how to use the key features of Terraform: count, depends_on, and provisioner for epic infrastructure management.

**Prerequisites**
- [Terraform](https://www.terraform.io/downloads.html) installed on your local machine
- AWS account with appropriate IAM permissions

**Getting Started**
1. Clone the repository to your local machine.
2. Navigate to the root directory of the cloned repository.
3. Open the variables.tf file and update the variables with your own values.
4. Initialize the Terraform directory: terraform init
5. Create an execution plan: terraform plan
6. Apply the changes: terraform apply

**Contents**
- `main.tf`: This file contains the main configuration for provisioning the AWS infrastructure using Terraform.
- `variables.tf`: This file contains the input variables for the AWS resources.
- `terraform.tfvars`: This file contains the aws access and secret values for AWS access.
- `README.md`: This file provides information about the repository.

**Conclusion**
By the end of this tutorial, you will have a clear understanding of how to use count, depends_on, and provisioner in Terraform for epic infrastructure management. You will be able to apply this knowledge to your own infrastructure management tasks, making your life as a DevOps engineer easier and more efficient.

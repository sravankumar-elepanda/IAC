module "ec2_instance" {
  source = "./ec2"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
}

output "instance_id" {
  value = module.ec2_instance.instance_id
}

output "instance_Public_IP" {
  value = module.ec2_instance.instance_Public_IP
}

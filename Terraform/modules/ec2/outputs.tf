output "instance_id" {
  value = aws_instance.ec2_instance[0].id
}

output "instance_Public_IP" {
  value = aws_instance.ec2_instance[0].public_ip
}

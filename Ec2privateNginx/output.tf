output "instance_id" {
  value = tolist(aws_instance.ec2.*.id)
}

output "private_ip" {
  value = tolist(aws_instance.ec2.*.private_ip)
  
}
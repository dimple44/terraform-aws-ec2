# ec2 instance public ip
output "instance_publicip" {
  description = "ec2 instance public ip"
  value       = aws_instance.ec2demo[0].public_ip
}
# ec2 instance public dns
output "instance_publicdns" {
  description = "ec2 instance public dns"
  value       = aws_instance.ec2demo[1].public_dns
}

# Output - For Loop with List
output "for_output_list" {
  description = "For Loop with List"
  value = [for instance in aws_instance.ec2demo: instance.public_dns ]
}

# Output - For Loop with Map
output "for_output_map1" {
  description = "For Loop with Map"
  value = {for instance in aws_instance.ec2demo: instance.id => instance.public_dns}
}

# Output - For Loop with Map Advanced
output "for_output_map2" {
  description = "For Loop with Map - Advanced"
  value = {for c, instance in aws_instance.ec2demo: c => instance.public_dns}
}

# Output Legacy Splat Operator (latest) - Returns the List
output "legacy_splat_instance_public_dns" {
  description = "Legacy Splat Expression"
  value = aws_instance.ec2demo.*.public_dns
}  

# Output Latest Generalized Splat Operator - Returns the List
output "latest_splat_instance_public_dns" {
  description = "Generalized Splat Expression"
  value = aws_instance.ec2demo[*].public_dns
}
# ec2 instance public ip
output "instance_publicip" {
  description = "ec2 instance public ip"
  value       = aws_instance.ec2-demo.public_ip
}
# ec2 instance public dns
output "instance_publicdns" {
  description = "ec2 instance public dns"
  value       = aws_instance.ec2-demo.public_dns
}
# Input Variables
# AWS region
variable "aws_region" {
  description = "region in which aws resources to be created"
  type        = string
  default     = "us-east-1"
}

# aws ec2 instance type
variable "instance_type" {
  description = "ec2 instance type"
  type        = string
  default     = "t2.micro"
}

# aws ec2 instance key pair
variable "instance_keypair" {
  description = "aws ec2 key pair that need to be associated with ec2 instance"
  type        = string
  default     = "awslearning"
}


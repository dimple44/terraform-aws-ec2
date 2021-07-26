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

# AWS EC2 Instance Type - List
variable "instance_type_list" {
  description = "EC2 Instance Type"
  type = list(string)
  default = ["t2.micro", "t2.small"]
}
# instance type of list count starts from 0,1,2 ,3  so on
# AWS EC2 Instance Type - Map
variable "instance_type_map" {
  description = "EC2 Instance Type"
  type = map(string)
  default = {
    "dev" = "t2.micro"
    "qa"  = "t2.small"
    "prod" = "t2.medium"
  }
}



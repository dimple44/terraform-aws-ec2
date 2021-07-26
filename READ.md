################################  Terraform Variables and Datasources ##########################################3

#### Step-00: Pre-requisite Note

Create a terraform-key in AWS EC2 Key pairs which we will reference in our EC2 Instance

#### Step-01: Introduction

Terraform Concepts

## Terraform Input Variables
## Terraform Datasources
## Terraform Output Values

#### What are we going to learn ?

#### Learn about Terraform Input Variable basics

    AWS Region
    Instance Type
    Key Name

#### Define Security Groups and Associate them as a List item to AWS EC2 Instance

    terraform-sg

#### Learn about Terraform Output Values

    Public IP
    Public DNS

    Get latest EC2 AMI ID Using Terraform Datasources concept
    We are also going to use existing EC2 Key pair terraform-key
    Use all the above to create an EC2 Instance in default VPC

#### Step-02: c3-variables.tf - Define Input Variables in Terraform

    Terraform Input Variables
    Terraform Input Variable Usage - 10 different types

# AWS Region
variable "aws_region" {
  description = "Region in which AWS Resources to be created"
  type = string
  default = "us-east-1"  
}

# AWS EC2 Instance Type
variable "instance_type" {
  description = "EC2 Instance Type"
  type = string
  default = "t2.micro"  
}

# AWS EC2 Instance Key Pair
variable "instance_keypair" {
  description = "AWS EC2 Key pair that need to be associated with EC2 Instance"
  type = string
  default = "awslearning"
}

############   Reference the variables in respective .tffies

# c1-versions.tf
region  = var.aws_region

# c2-ec2instance.tf
instance_type = var.instance_type
key_name = var.instance_keypair  

###############################  Step-03: c4-ec2securitygroups.tf - Define Security Group Resources in Terraform #############################

    Resource: aws_security_group

resource "aws_security_group" "terraform-sg" {
  name        = "terraform-sg"
  description = "allow port 22"
  # am using default vpc so i dont have a need to specify vpc_id here
  ingress {
    description = "allow port 22"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "allow all ip and ports outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # allow http port 
  ingress {
    description = "allow port 80"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "allow all ip and ports outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # allow https port
  ingress {
    description = "allow port 443"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "allow all ip and ports outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    name = "terraform"
  }
}

###################  Reference the security groups in c2-ec2instance.tf file as a list item

### List Item

vpc_security_group_ids = [aws_security_group.vpc-ssh.id, aws_security_group.vpc-web.id]  
#################################### Step-04: c4-ami-datasource.tf - Define Get Latest AMI ID for Amazon Linux2 OS #############################

    Data Source: aws_ami

# Get latest AMI ID for Amazon Linux2 OS
# Get Latest AWS AMI ID for Amazon2 Linux

data "aws_ami" "amzlinux2" {
  most_recent = true
  owners = [ "amazon" ]
  filter {
    name = "name"
    values = [ "amzn2-ami-hvm-*-gp2" ]
  }
  filter {
    name = "root-device-type"
    values = [ "ebs" ]
  }
  filter {
    name = "virtualization-type"
    values = [ "hvm" ]
  }
  filter {
    name = "architecture"
    values = [ "x86_64" ]
  }
}

#####    Reference the datasource in c2-ec2instance.tf file

# Reference Datasource to get the latest AMI ID
ami = data.aws_ami.amzlinux2.id 

##############################  Step-05: c2-ec2instance.tf - Define EC2 Instance Resource ###################################

    Resource: aws_instance

#### EC2 Instance
resource "aws_instance" "ec2-demo" {
  ami = data.aws_ami.amzlinux2.id 
  instance_type = var.instance_type
  user_data = file("${path.module}/Script-httpd.sh")
  key_name = var.instance_keypair
  vpc_security_group_ids = ["${aws_security_group.terraform-sg.id}"]  
  tags = {
    "Name" = "ec2-demo"
  }
}

#################################  Step-06: c6-outputs.tf - Define Output Values  ####################################

    Output Values

#### Terraform Output Values

output "instance_publicip" {
  description = "EC2 Instance Public IP"
  value = aws_instance.myec2vm.public_ip
}

output "instance_publicdns" {
  description = "EC2 Instance Public DNS"
  value = aws_instance.myec2vm.public_dns
}

####################################  Step-07: Execute Terraform Commands ################################

#### Terraform Initialize

terraform init

Observation:
1) Initialized Local Backend
2) Downloaded the provider plugins (initialized plugins)
3) Review the folder structure ".terraform folder"

#### Terraform Validate

terraform validate

Observation:
1) If any changes to files, those will come as printed in stdout (those file names will be printed in CLI)

#### Terraform Plan

terraform plan

Observation:
1) Verify the latest AMI ID picked and displayed in plan
2) Verify the number of resources that going to get created
3) Verify the variable replacements worked as expected

#### Terraform Apply

terraform apply 

[or]

terraform apply -auto-approve

Observations:
1) Create resources on cloud
2) Created terraform.tfstate file when you run the terraform apply command
3) Verify the EC2 Instance AMI ID which got created

#########################   Step-08: Access Application  #########################

# Access public ip

#########################   Step-09: Clean-Up  ###########################

#### Terraform Destroy
terraform plan -destroy  # You can view destroy plan using this command
terraform destroy

####  Clean-Up Files
sudo rm -rf .terraform*
sudo rm -rf terraform.tfstate*

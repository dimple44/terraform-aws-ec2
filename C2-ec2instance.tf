# resource :ec2 instance
resource "aws_instance" "ec2-demo" {
  ami = data.aws_ami.amzlinux2.id
  instance_type          = var.instance_type
  user_data              = file("${path.module}/Script-httpd.sh")
  key_name               = var.instance_keypair
  vpc_security_group_ids = ["${aws_security_group.terraform-sg.id}"]
  tags = {
    "Name" = "ec2-demo"
  }
}


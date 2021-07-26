# resource :ec2 instance
resource "aws_instance" "ec2demo" {
  ami = data.aws_ami.amzlinux2.id
  #instance_type          = var.instance_type
  instance_type = var.instance_type_list[0]   # for list
  #instance_type = var.instance_type_map["dev"]  # for map
  user_data              = file("${path.module}/script-httpd.sh")
  key_name               = var.instance_keypair
  vpc_security_group_ids = ["${aws_security_group.terraform-sg.id}"]
  count = 3
  tags = {
    "Name" = "ec2demo-${count.index}"
  }
}


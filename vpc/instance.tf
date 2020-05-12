resource "aws_instance" "example" {
  ami           = data.aws_ami.latest-ubuntu.id
  instance_type = "t2.micro"
  # the VPC subnet
  subnet_id              = aws_subnet.main-public-1.id
  vpc_security_group_ids = [aws_security_group.allow-ssh.id]
  key_name               = var.key_name
}

resource "aws_instance" "web" {
  ami                    = data.aws_ami.latest-ubuntu.id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.main-public-2.id
  vpc_security_group_ids = [aws_security_group.allow-ssh.id]
  key_name               = var.key_name
}


resource "aws_instance" "web2" {
  ami                    = data.aws_ami.latest-ubuntu.id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.main-public-3.id
  vpc_security_group_ids = [aws_security_group.allow-ssh.id]
  key_name               = var.key_name

  user_data = data.template_cloudinit_config.couldinit-example.rendered
}
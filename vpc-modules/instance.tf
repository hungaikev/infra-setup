data "aws_ami" "latest-ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "web" {
  ami = data.aws_ami.latest-ubuntu.id
  instance_type = "t2.micro"

  #the VPC subnet
  subnet_id = module.vpc-prod.public_subnets[0]

  # the security group
  vpc_security_group_ids = [aws_security_group.allow-ssh-prod.id]

  # the public key
  key_name = var.key_name
}

resource "aws_instance" "web-dev" {
  ami = data.aws_ami.latest-ubuntu.id
  instance_type = "t2.micro"

  #the VPC subnet
  subnet_id = module.vpc-dev.public_subnets[0]

  # the security group
  vpc_security_group_ids = [aws_security_group.allow-ssh-dev.id]

  # the public key
  key_name = var.key_name
}
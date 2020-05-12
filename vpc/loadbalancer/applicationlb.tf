resource "aws_alb" "my-alb" {
  name = "my-alb"
  subnets = []
  security_groups = [aws_security_group.elb-securitygroup.id]

  tags = {
    Name = "my-elb"
  }
}

resource "aws_alb_target_group" "frontend-target-group" {
  name = "alb-target-group"
  port = 80
  protocol = "HTTP"
  vpc_id = ""
}
resource "aws_elb" "my-elb" {
  name = "myelb"
  subnets = [aws_subnet.main-public-1.id, aws_subnet.main-public-2.id]
  security_groups = [aws_security_group.elb-securitygroup.id]

  listener {
    instance_port = 80
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }

  health_check {
    healthy_threshold = 2
    interval = 0
    target = "HTTP:80/"
    timeout = 3
    unhealthy_threshold = 2
  }

  instances = ["" ] # optional, you can also attach an ELB to an autoscaling group
  cross_zone_load_balancing = true
  connection_draining = true
  connection_draining_timeout = 400

  tags = {
    Name = "my-elb"
  }
}


resource "aws_security_group" "myinstance" {
  vpc_id = ""
  name = "myinstance"
  description = "Security Group for my instance"
  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 80
    protocol = "tcp"
    to_port = 80
    security_groups = [aws_security_group.elb-securitygroup.id]
  }

  tags = {
    Name = "myinstance"
  }
}

resource "aws_security_group" "elb-securitygroup" {
  vpc_id = ""
  name = "elb"
  description = "security group for load balancer"
  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 80
    protocol = ""
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "elb"
  }
}
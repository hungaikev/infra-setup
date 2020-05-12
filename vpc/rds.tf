resource "aws_db_parameter_group" "mariadb-parameters" {
  family      = "mariadb10.1"
  name        = "mariadb-parameters"
  description = "MariaDB parameter group"

  parameter {
    name  = "max_allowed_packet"
    value = "16777216"
  }
}

resource "aws_db_subnet_group" "mariadb-subnet" {
  name        = "mariadb-subnet"
  description = "RDS subnet group"
  subnet_ids  = [aws_subnet.main-private-1.id, aws_subnet.main-private-2.id]
}

resource "aws_security_group" "allow-mariadb" {
  vpc_id      = aws_vpc.main.id
  name        = "allow-mariadb"
  description = "allow-mariadb"
  ingress {
    from_port       = 3306
    protocol        = "tcp"
    to_port         = 3306
    security_groups = [aws_security_group.allow-ssh.id] # allow access from our example instance
  }

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
    self        = true
  }

  tags = {
    Name = "allow-mariandb"
  }
}

resource "aws_db_instance" "mariadb" {
  allocated_storage       = 100
  engine                  = "mariadb"
  engine_version          = "10.1.14"
  instance_class          = "db.t2.small"
  identifier              = "mariadb"
  name                    = "mariadb"
  username                = "root"
  password                = "123456.ab"
  db_subnet_group_name    = aws_db_subnet_group.mariadb-subnet.name
  parameter_group_name    = aws_db_parameter_group.mariadb-parameters.name
  multi_az                = false
  vpc_security_group_ids  = [aws_security_group.allow-mariadb.id]
  storage_type            = "gp2"
  backup_retention_period = 30 #how long you are going to keep your backups
  availability_zone       = aws_subnet.main-private-1.availability_zone
  tags = {
    Name = "mariabd-instance"
  }
}
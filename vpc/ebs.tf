resource "aws_ebs_volume" "ens-volume-1" {
  availability_zone = "eu-central-1a"
  size              = 20
  type              = "gp2"

  tags = {
    Name = "extra volume"
  }
}

resource "aws_volume_attachment" "ebs-volume-1-attachment" {
  device_name = "/dev/xvdh"
  instance_id = aws_instance.example.id
  volume_id   = aws_ebs_volume.ens-volume-1.id
}
data "aws_ami" "amazon-linux-2" {
 most_recent = true


 filter {
   name   = "owner-alias"
   values = ["amazon"]
 }

 filter {
   name   = "name"
   values = ["amzn2-ami-hvm*"]
 }
}

resource "aws_security_group" "retosg" {
  name        = "devopschallenge-"
  description = "Security group for Reto"
  vpc_id      = "vpc-fa31f891"
}

resource "aws_security_group_rule" "ssh_ingress_access" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = "${aws_security_group.retosg.id}"
  cidr_blocks       = ["11.22.33.44/32"]
}

resource "aws_key_pair" "retopem" {
  key_name   = "deployer-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDlDp8tu+z5vY4v7gjFEtKG3JPMDSMEhYGIaVuC6reHEliybyGwiUP+QGaNZbRLl+lPo1J1YVBzgImlNICVASt5XGrbZFgIkCRxNOB/ft5LL326vhW6xpnb6lpkk0rZ1/w4Qdj9Yqn/UqW3dZyxxowRuL/T98GDceKFlWKxbHt98qneN86NqP+h17psENiYVPT6q7U1Bhm34rL/vnsequtbTkAhwHZu3i0LHTO4tzVzHR84dJjAKzOqBWuUCHOIwMezJwdtGSrC55O2iSF2ffb9QMVHZ0zzvaN8rA71GIrIN0apqDftY34pkTLLZA3Szv1QEij10dO+5ijpWCkeFu9VJ9CtcR04vCkobwE7DJ+61nXmBKzzztCWdE2V9ISf6Lxlx1rgMT3P3UpZwwpK4ngel9HqdWFWU+TnbqxeHzT1BdvKqKV2X5fm6wOSnfm9bArFBsRLAeSElb/StU80MrH238EkvEQjxdjPD2zH38rEdn6ISV9kSStxrIG3DSreHHJFrFH4I6FOkJ/v6xrmdOPKRQXZioiJCfy5rxgvJCq2GaMigOW/4ellIIrPYxX1wTV1MqclgEbrt72Uy2MGkJI1DEfp6HxMXMfc6OaxFy6Xww+y96Z5MM3I8uCTj7NKgptqiDZ2/sfDecwyqPMoxGd06Mq/X4jfJ3Eq7iEmkpdxMQ=="
}

resource "aws_instance" "retoec2" {
  subnet_id = "subnet-895baae2"

  instance_type               = "t3a.nano"
  vpc_security_group_ids      = ["${aws_security_group.retosg.id}"]
  associate_public_ip_address = true

  key_name = "${aws_key_pair.retopem.key_name}"

  ebs_block_device {
    device_name = "/dev/sda1"
    volume_size = 20
  }

  tags {
    Name = "retoec2-myinstance01"
  }

  ami               = "${data.aws_ami.amazon-linux-2.id}"
  availability_zone = "us-east-2a"
}

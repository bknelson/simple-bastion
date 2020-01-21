resource "aws_instance" "xmage" {
  ami                         = "${var.ami_id}"
  instance_type               = "m5.large"
  key_name                    = "${var.ssh_key_name}"
  subnet_id                   = "${element(split(",", var.subnet_list), 5)}"
  vpc_security_group_ids      = ["${aws_security_group.xmage.id}"]
  associate_public_ip_address = true
  user_data                   = "${data.template_file.userdata.rendered}"

  tags {
    Name = "${var.name}"
    Role = "xmage"
  }
}

resource "aws_security_group" "xmage" {
  name        = "xmage"
  description = "restricted by user ip"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.user_ip}/32"]
  }

  ingress {
    from_port   = 17171
    to_port     = 17171
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 17179
    to_port     = 17179
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_route53_record" "xmage" {
  zone_id = "${data.aws_route53_zone.dns_zone.zone_id}"
  name    = "${var.name}.${data.aws_route53_zone.dns_zone.name}"
  type    = "A"
  records = ["${aws_instance.xmage.public_ip}"]
  ttl     = 60
}

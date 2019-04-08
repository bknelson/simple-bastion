data "aws_route53_zone" "dns_zone" {
  name = "${var.zone_name}"
}

data "template_file" "userdata" {
  template = "${file("${path.module}/userdata.template")}"
  vars = {
    zone_name = "${var.zone_name}"
  }
}
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# DEPLOY A SINGLE EC2 INSTANCE
# This template uses runs a simple "Hello, World" web server on a single EC2 Instance
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# ------------------------------------------------------------------------------
# CONFIGURE OUR AWS CONNECTION
# ------------------------------------------------------------------------------
# Should change to eu region
provider "aws" {
  region = "us-east-1"
}

# ---------------------------------------------------------------------------------------------------------------------
# DEPLOY A SINGLE EC2 INSTANCE
# ---------------------------------------------------------------------------------------------------------------------

data "template_file" "user_data" {
  template = "./userdata/data.tpl"
}

resource "aws_instance" "webserver" {
  # amzn2
  ami = "ami-afd15ed0"
  instance_type = "t2.micro"
  key_name = "terraform_key"
  vpc_security_group_ids = ["${aws_security_group.instance.id}"]
  user_data = "${file("./userdata/data.tpl")}"

  tags {
    Name = "terraform-webserver"
  }

#   provisioner "file" {
#   source      = "httpd.conf"
#   destination = "/etc/httpd/conf/httpd.conf"
# }

}
# ---------------------------------------------------------------------------------------------------------------------
# CREATE THE SECURITY GROUP THAT'S APPLIED TO THE EC2 INSTANCE
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_security_group" "instance" {
  name = "terraform-instance"

  # Inbound HTTP from anywhere
  ingress {
    from_port = "${var.server_port}"
    to_port = "${var.server_port}"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = "${var.server_port}"
    to_port = "${var.server_port}"
    protocol = "tcp"
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    from_port = "${var.ssh_port}"
    to_port = "${var.ssh_port}"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = "${var.ssh_port}"
    to_port = "${var.ssh_port}"
    protocol = "tcp"
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    from_port = "${var.https_port}"
    to_port = "${var.https_port}"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = "${var.https_port}"
    to_port = "${var.https_port}"
    protocol = "tcp"
    ipv6_cidr_blocks = ["::/0"]
  }
  egress  {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#Should really variablise zone_id

  resource "aws_route53_record" "www" {
    zone_id = "Z1MR82TXA6X7U"
    name    = "www.jlamhelloworld.co.uk"
    type    = "A"
    ttl     = "300"
    records = ["${aws_instance.webserver.public_ip}"]
  }
  resource "aws_route53_record" "root" {
    zone_id = "Z1MR82TXA6X7U"
    name    = "jlamhelloworld.co.uk"
    type    = "A"
    ttl     = "300"
    records = ["${aws_instance.webserver.public_ip}"]
  }

resource "aws_instance" "bastion-1a" {
    ami = "${lookup(var.amis, var.aws_region)}"
    availability_zone = "eu-west-1a"
    instance_type = "${var.instance_type}"
    key_name = "${var.aws_key_name}"
    vpc_security_group_ids = ["${aws_security_group.bastion.id}"]
    subnet_id = "${aws_subnet.eu-west-1a-public.id}, ${aws_subnet.eu-west-1b-public.id}"
    associate_public_ip_address = true
    source_dest_check = false

    tags = {
        Name = "Bastion Server 1a"
    }
}

output "bastion_public_ip_1a" {
  value = "${aws_instance.bastion-1a.public_ip}"
}

resource "aws_security_group" "bastion" {
  name   = "bastion-security-group"
  vpc_id = "${aws_vpc.default.id}"

  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = -1
    from_port   = 0 
    to_port     = 0 
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "bastion_key" {
  key_name   = "SSH Key Pair for bastion"
  public_key = "${var.ssh_key_name}"
}
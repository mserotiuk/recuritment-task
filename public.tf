/*
  Public Servers
*/
resource "aws_security_group" "public" {
    name = "vpc_public"
    description = "Allow incoming HTTP connections."

    ingress {
        from_port = 8000
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 8000
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = -1
        to_port = -1
        protocol = "icmp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    vpc_id = "${aws_vpc.default.id}"

    tags = {
        Name = "PublicServerSG"
    }
}

resource "aws_instance" "public-server-1a" {
    ami = "${lookup(var.amis, var.aws_region)}"
    availability_zone = "eu-west-1a"
    instance_type = "${var.instance_type}"
    key_name = "${var.aws_key_name}"
    vpc_security_group_ids = ["${aws_security_group.public.id}"]
    subnet_id = "${aws_subnet.eu-west-1a-public.id}"
    associate_public_ip_address = true
    source_dest_check = false

    tags = {
        Name = "Public Subnet Server 1a"
    }

    provisioner "file" {
        source      = "~/scripts/setup-nginux-a.sh"
        destination = "/tmp/setup-nginux.sh"
    }
    
    provisioner "remote-exec" {
        inline = [
        "chmod +x /tmp/setup-nginux.sh",
        "sudo /tmp/setup-nginux.sh",
        ]
    }
}

resource "aws_instance" "public-server-1b" {
    ami = "${lookup(var.amis, var.aws_region)}"
    availability_zone = "eu-west-1b"
    instance_type = "${var.instance_type}"
    key_name = "${var.aws_key_name}"
    vpc_security_group_ids = ["${aws_security_group.public.id}"]
    subnet_id = "${aws_subnet.eu-west-1a-public.id}"
    associate_public_ip_address = true
    source_dest_check = false

    tags = {
        Name = "Public Subnet Server 1b"
    }

    provisioner "file" {
        source      = "~/scripts/setup-nginux-b.sh"
        destination = "/tmp/setup-nginux.sh"
    }
    
    provisioner "remote-exec" {
        inline = [
        "chmod +x /tmp/setup-nginux.sh",
        "sudo /tmp/setup-nginux.sh",
        ]
    }
}

resource "aws_eip" "public-server-1a" {
    instance = "${aws_instance.public-server-1a.id}"
    vpc = true
}


resource "aws_eip" "public-server-1b" {
    instance = "${aws_instance.public-server-1b.id}"
    vpc = true
}